From: prasadjoshi124@gmail.com (Prasad Joshi)
Date: Mon, 26 Aug 2013 12:07:00 +0530
Subject: Best way to exercise NVME ioctls
Message-ID: <CAFEQX0f1Wm_gxyXws-L3LzGP0-WE1SSr-aVCvYtxsU=umSXovA@mail.gmail.com>

Hi All,

I am doing experiments with nvme linux driver. I would like to write
some sample programs which uses nvme ioctls. Specifically I wanted to
invoke identify command to start with. nvme.h header file contains two
structures "nvme_admin_cmd" and "nvme_identify", both seem to be
identical.

Would there be any problem if I use any one of them for calling nvme IOCTL?
What will be the best and ideal way?

Thanks and Warm Regards,
Prasad
