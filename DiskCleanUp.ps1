#DFO-MPO disk cleanup project- Disk cleaner
#Authors - Mohammad Al-Noufal and Michael Gornik
##################################################################################################################################################################
#Free diskspace clalcutor
$FreeSpaceBefore = ((get-WmiObject win32_logicaldisk | ? DeviceID -eq "c:").FreeSpace )  / (1024 * 1024 * 1024 )
$freeSpaceNow = [math]::Round($FreeSpaceBefore) 
$needFree = 20 - $freeSpaceNow1 



$path = "C:\Users"
#create a list for the current User Profiles in thye OS
#$oldList= New-Object System.Collections.arraylist 
$oldListBefore = New-Object System.Collections.arraylist #Initiate 1st array list - status = empty
$oldList2= New-Object System.Collections.arraylist #Initiate 2nd array list - status = empty
$checkArray = New-Object System.Collections.arraylist
#Form is created
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Disk CleanUp Assistant / Assistant de nettoyage de disque"
$Form.Size = New-Object System.Drawing.Size(1225,900)
$Form.StartPosition = "CenterScreen"
$Form.KeyPreview = $True
$Form.MaximumSize = $Form.Size
$Form.MinimumSize = $Form.Size



##DFO Picture
$img = [System.Drawing.Image]::Fromfile("$psscriptroot\DFOCrest.jpg")
$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Width = $img.Size.Width
$pictureBox.Height = $img.Size.Height
$pictureBox.Image = $img
$pictureBox.Location =New-Object System.Drawing.Point(900,10)
$form.controls.add($pictureBox)






$i = 280  #Vertical start point of checkbox 
$j = 20
$k = $j + 177
#adjust listbox size
$sizeArray = New-Object System.Collections.arraylist
$sizeArray = Get-ChildItem -Path "C:\Users"
$l = (($sizeArray).count) * $j 
$count = 0
#create listbox to be populated with user profiles
$lBox = New-object System.windows.forms.CheckedListBox
$tempArray = New-Object System.Collections.arraylist
$lBox.CheckOnClick = $true
$Form.Controls.Add($lBox)
$lBox.Font = [System.Drawing.Font]::new("Microsoft Sans Serif", 10.5, [System.Drawing.FontStyle]::Bold)
$lBox.Size = New-Object System.Drawing.Size(177,$l)
$lBox.Location = New-Object System.Drawing.Size($j ,  $i) 

		$currentUser = (Get-WMIObject -class Win32_ComputerSystem).username
			if ( ($currentUser).Length -lt 1){ $userName = "Click Ok to continue"}
			else{ $userName = $currentUser.Substring(4)}



#Getting user profiles that were used on machine and last dates they have been user then adding them to the checked list box
Get-ChildItem -Path "C:\Users" | foreach {
	$checkBox = "$checkBox$count"
	$temp1 = $_.LastWriteTimeUtc
		$temp1.ToString("yyyy-MM-dd")
		$y = (([datetime]"$temp1" ).Year)
		$m = (([datetime]"$temp1" ).Month)
		$d = (([datetime]"$temp1" ).Day)
		$day = (([datetime]"$temp1" ).DayOfWeek)
		$theDate = " $d/$m/$y"
		$theDate
	$temp2 = $_.BaseName
	$temp = "$temp2"
	$blackList = "Public","systemprofile","LocalService","Administrator",$userName
	if ($temp2 -notin $blackList){
	$oldList2.add("$temp ")
	$oldListBefore.add("$temp")
	
	if($temp.count -lt 1  -or $temp -eq $Null){
		[System.Windows.Forms.MessageBox]::Show("No user profile cleanup is required/Aucun nettoyage de profil n'est requis ")

	}
	else{
	$lBox.Items.Add($temp)  ###  to fill the list with  user's names
	}	
		
		
#date list
###########################################
		$lBox2 = New-object System.windows.forms.listbox
		#$lBox2.CheckOnClick = $true
		$lBox2.enabled =$false
		$lBox2.Items.AddRange($theDate)
		$Form.Controls.Add($lBox2)
		#$temp1.ToDate()
		$lBox2.Size = New-Object System.Drawing.Size(80,22)
		$lbox2.Location = New-Object System.Drawing.Size($k ,  $i) 
		$lBox2.Font = [System.Drawing.Font]::new("Microsoft Sans Serif", 9, [System.Drawing.FontStyle]::Bold)
		$i = $i+20


$count++


	}
}


[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

  



			$label = New-Object System.Windows.Forms.label
			$label.Location = New-Object System.Drawing.Size(15,20)
			$label.Size = New-Object System.Drawing.Size(900,40)
			$label.Text = "DFO Windows 10 Upgrade Project / Projet de mise à niveau Windows 10 du MPO"
			$label.ForeColor= "Blue"
			$label.Font = [System.Drawing.Font]::new("Microsoft Sans Serif", 16, [System.Drawing.FontStyle]::Bold)
		    $Form.Controls.Add($label)
							
				$label = New-Object System.Windows.Forms.label
				$label.Location = New-Object System.Drawing.Size(15,70)
				$label.Size = New-Object System.Drawing.Size(900,80)
						if ($freeSpaceNow -le 20){
								$label.Text = " $freeSpaceNow GB is less than required diskpace. Minimum diskspace required is 20GB / $freeSpaceNow est inférieur à l'espace disque requis. L'espace disque minimum requis est 20GB "
								$label.Text = "red"
							}
						else{
								$label.Text = "Your current diskspace is $freeSpaceNow GB. This meets our requirements, no further cleanup is needed at this point /  L'espace disque libre est $freeSpaceNow GB. Aucun nettoyage supplémentaire n'est requis."

								$label.ForeColor = "green"
							}
								$label.Font = New-Object System.Drawing.Font("New Times Roman", 15)
								$Form.Controls.Add($label)
								
														
	                     #creating labels
			            $label = New-Object System.Windows.Forms.label
                        $label.Location = New-Object System.Drawing.Size(10,150)
                        $label.Size = New-Object System.Drawing.Size(900,50)
                        $label.Text = "Please be careful! `r some user profiles may belong to other frequent users of this machine / 
						Soyez prudents ! `r certains profils d'utilisateurs peuvent appartenir à d'autres utilisateurs fréquents de cette machine."
						$label.Font =  [System.Drawing.Font]::new("Microsoft Sans Serif", 11.5, [System.Drawing.FontStyle]::Bold)
                        $Form.Controls.Add($label)
						
						
						
						$label = New-Object System.Windows.Forms.label
						$label.Location = New-Object System.Drawing.Size(950,360)
						$label.Size = New-Object System.Drawing.Size(900,30)
						$label.Text = "Fisheries and Oceans Canada
												Pêches et Océans Canada "
						$label.Font =  [System.Drawing.Font]::new("Microsoft Sans Serif", 11, [System.Drawing.FontStyle]::Bold)
						$Form.Controls.Add($label)

						$label = New-Object System.Windows.Forms.label
						$label.Location = New-Object System.Drawing.Size(6,250)
						$label.Size = New-Object System.Drawing.Size(900,30)
						$label.Text = "User Name/Nom d'utilisateur || Date modified /Date modifiée"
						$label.Font =  [System.Drawing.Font]::new("Microsoft Sans Serif", 9, [System.Drawing.FontStyle]::Bold)
						$Form.Controls.Add($label)



				#User information label
				$label = New-Object System.Windows.Forms.label
				$label.Location = New-Object System.Drawing.Size(33,680)
				$label.Size = New-Object System.Drawing.Size(350,30)
				$label.Text = " The current logged in user is \ L'utilisateur actuellement connecté est :"
				$label.Font =  [System.Drawing.Font]::new("Microsoft Sans Serif", 11, [System.Drawing.FontStyle]::Bold)
				$Form.Controls.Add($label)
				
					$label = New-Object System.Windows.Forms.label
					$label.Location = New-Object System.Drawing.Size(420,690)
					$label.Size = New-Object System.Drawing.Size(450,30)
					$label.Text = "Exit the program / Quitter le programme :"
					$label.Font =  [System.Drawing.Font]::new("Microsoft Sans Serif", 12, [System.Drawing.FontStyle]::Bold)
					$Form.Controls.Add($label)

					$label = New-Object System.Windows.Forms.label
					$label.Location = New-Object System.Drawing.Size(80,720)
					$label.Size = New-Object System.Drawing.Size(130,23)
					$label.Text = "{ $userName }"
					$label.Font =  [System.Drawing.Font]::new("Microsoft Sans Serif", 12, [System.Drawing.FontStyle]::Bold)
					$label.ForeColor = "navy"
					$Form.Controls.Add($label)


			########### Create the button OK 
			$OKButton = New-Object System.Windows.Forms.Button
			$OKButton.Location = New-Object System.Drawing.Size(80,770)
			$OKButton.Size = New-Object System.Drawing.Size(100,40)
			$OKButton.Text = "OK"
			$OKButton.ForeColor= "red"
			$OKButton.Font = [System.Drawing.Font]::new("Microsoft Sans Serif", 11, [System.Drawing.FontStyle]::Bold)
			$Form.Controls.Add($OKButton)


			#Exit the program
		$CloseButton = New-Object System.Windows.Forms.Button
		$CloseButton.Location = New-Object System.Drawing.Size(480,750)
		$CloseButton.Size = New-Object System.Drawing.Size(150,60)
		$CloseButton.Text = "Exit / Quitter"
		$CloseButton.ForeColor= "Green"
		$CloseButton.Font = [System.Drawing.Font]::new("Microsoft Sans Serif", 11, [System.Drawing.FontStyle]::Bold)
		$Form.Controls.Add($CloseButton)	

	$CloseButton.Add_Click(
						{$Form.Close()})

#ok button
$OKButton.Add_Click(
        {
			
if($lBox.CheckedItems){
	 $deleteList = New-Object System.Collections.arraylist
		$deleteList = $lBox.CheckedItems
		 $formTwo = New-Object System.Windows.Forms.Form
                        $formTwo.Text = "Disk CleanUp Assistant / Assistant de nettoyage de disque"
                        $formTwo.Size = New-Object System.Drawing.Size(600,800)
                        $formTwo.StartPosition = "CenterScreen"
                   

		                $label = New-Object System.Windows.Forms.label
                        $label.Location = New-Object System.Drawing.Size(10,20)
                        $label.Size = New-Object System.Drawing.Size(600,30)
		$temp3 = ""
		$h = 60
		foreach ($b in $deleteList ){
						$temp3 = "$temp3" +"$b "
			
					#conformation label

						$label.Text = "Are you sure you would like to delete / Êtes-vous sûr de vouloir supprimer? " 
						$label.Font = [System.Drawing.Font]::new("Microsoft Sans Serif", 11)
						$label.ForeColor= "red"
                        $formTwo.Controls.Add($label)

	
					
		#list that holds selected users
		$lBoxThree = New-object System.windows.forms.listbox
		$lBoxThree.enabled =$false
		$lBoxThree.Items.AddRange($b)
		$FormTwo.Controls.Add($lBoxThree)
		$lBoxThree.Size = New-Object System.Drawing.Size(225,33)
		$lBoxThree.Location = New-Object System.Drawing.Size(20 , $h) 
		$h = $h + 25
		$lBoxThree.Font = [System.Drawing.Font]::new("Microsoft Sans Serif", 9, [System.Drawing.FontStyle]::Bold)
		$i = $i+20
			#creates delete button as well as click event
		}
			$deleteButton = New-Object System.Windows.Forms.Button
			$deleteButton.Location = New-Object System.Drawing.Size(400,100)
			$deleteButton.Size = New-Object System.Drawing.Size(100,40)
			$deleteButton.Text = "OK"
			$deleteButton.ForeColor= "red"
			$deleteButton.Font = [System.Drawing.Font]::new("Microsoft Sans Serif", 11, [System.Drawing.FontStyle]::Bold)
			$FormTwo.Controls.Add($deleteButton)
				$deleteButton.Add_Click(
						{
							 #Delete user profile and remove deleted profile from list
						foreach ( $uName in $deleteList ){
											
							$deleteProfile = (Get-CimInstance win32_userprofile | ? localpath -eq "c:\users\$uName")  
											Remove-CimInstance -InputObject $deleteProfile
							[System.Windows.Forms.MessageBox]::Show("$uName is no longer exists")
                                 
							if($deleteProfile){
							$lBox.Items.remove($uName)
								
							}
							}

							
						$FormTwo.Close()
						})

			


					#exit 
						$exitButton = New-Object System.Windows.Forms.Button
						$exitButton.Location = New-Object System.Drawing.Size(400,160)
						$exitButton.Size = New-Object System.Drawing.Size(100,40)
						$exitButton.Text = "Back / Retour ⬅️"
						$exitButton.ForeColor= "Green"
						$exitButton.Font = [System.Drawing.Font]::new("Microsoft Sans Serif", 10)
						
						$FormTwo.Controls.Add($exitButton)
							$exitButton.Add_Click(
						{$FormTwo.Close()})



}
	else{

			 $formTwo = New-Object System.Windows.Forms.Form
                        $formTwo.Text = "Warning ⚠️ / Alerte ⚠️"
                        $formTwo.Size = New-Object System.Drawing.Size(650,250)
                        $formTwo.StartPosition = "CenterScreen"
						

		                $label = New-Object System.Windows.Forms.label
						$label.StartPosition = "CenterScreen"
                        $label.Location = New-Object System.Drawing.Size(25,50)
                        $label.Size = New-Object System.Drawing.Size(600,30)
		
						$label.Text = "Please select a user profile to delete / Veuillez sélectionner un utilisateur à supprimer. "
						$label.Font = [System.Drawing.Font]::new("Microsoft Sans Serif", 11)
						$label.ForeColor= "balck"
                        $formTwo.Controls.Add($label)

						$goBackButton = New-Object System.Windows.Forms.Button
						$goBackButton.Location = New-Object System.Drawing.Size(225,100)
						$goBackButton.Size = New-Object System.Drawing.Size(180,25)
						$goBackButton.Text = "Back / Retour ⬅"
						$goBackButton.ForeColor= "Blue"
						$goBackButton.Font = [System.Drawing.Font]::new("Microsoft Sans Serif", 10)
						
						$FormTwo.Controls.Add($goBackButton)
							$goBackButton.Add_Click(
						{$FormTwo.Close()})
	}
				

				[void]$formTwo.ShowDialog() 
})


$Form.ShowDialog()

#Disk space when process is over
$FreeSpaceafter = ((get-WmiObject win32_logicaldisk | ? DeviceID -eq "c:").FreeSpace )  / (1024 * 1024 * 1024 )
$freeSpaceNow4 = [math]::Round($FreeSpaceafter) 
## Log file
$endDate = (get-date -Format yyyy/mm/dd---HH:mm:ss) 
#End of program 



