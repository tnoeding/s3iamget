S3IAMGet
============

This bash script will grab S3 assets using IAM credentials.

### Getting Started:
From within the IAM based ec2 image, pull down this repository

```bash
git clone http://github.com/tnoeding/s3iamget.git
```

cd into the directory

```bash
cd s3iamget
```

make sure the script can run

```bash
chmod +x s3iamget.sh
```

run the s3iamget.sh script with the proper arguments

```bash
./s3iamget.sh <bucketname> <bucketlocation>
```

EXAMPLE

```bash
./s3iamget.sh testbucket dir1/dir2/file.txt
```
