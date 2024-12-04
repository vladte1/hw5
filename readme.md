
- create AWS ec2 instance using ubuntu 22.04 image ami-053b0d53c279acc90
- create script which will configure next systemd daemon:
- daemon check some folder1 and move any new files from it to folder2 - daemon should autostart with system. Put next lines to user data:
  systemctl daemon-reload systemctl start your_service systemctl enable your_service
  Tip: do not forget make infinity loop in your move-script
  Check:
  run aws run_instance ......
  ssh to your instance
  create files in folder1 and check folder2

## How to start: 
aws ec2 run-instances \
--image-id ami-053b0d53c279acc90 \
--count 1 \
--instance-type t2.micro \
--user-data file://user-data.sh \
--region us-east-1 --output json