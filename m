From: judy.brock@samsung.com (Judy Brock)
Date: Wed, 20 Sep 2017 03:21:29 +0000
Subject: Samsung SSD 960 EVO 500GB S3 issue
In-Reply-To: <CAAd53p4FfQ+L0J4-TuMqPLaOTs1i9afEHKA_tof+ZN6R6dn=Tw@mail.gmail.com>
References: <CGME20170920031552epcas5p4e89cc3b0c2fb64723d8954716326518c@epcas5p4.samsung.com>
 <CAAd53p4FfQ+L0J4-TuMqPLaOTs1i9afEHKA_tof+ZN6R6dn=Tw@mail.gmail.com>
Message-ID: <af96708c0e464dbda4053d432f358b59@samsung.com>

Hi Kai-Heng,

	>>Can you take a look?

I'm not in a group that works on or looks at linux bugs - I have passed along some of the exchanges here to internal groups.  I will do the same with the below but I guess I am an unofficial communication path to those internal groups. Will try to find out if there is anyone who is an officially better contact that can take more formal responsibility for these issues when they arise.

Thanks,
Judy

-----Original Message-----
From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com] 
Sent: Tuesday, September 19, 2017 8:16 PM
To: Judy Brock
Cc: Andy Lutomirski; linux-nvme
Subject: Samsung SSD 960 EVO 500GB S3 issue

Hi Judy,

Just found that Andy reached to you, apology for doing the same.

Here's another Samsung NVMe bug [1], this time it's not about PS4. Can you take a look?

A quick summary:
- The user runs a Ryzen desktop.
- A quick google shows that firmware version 2B7QCXE7 is already latest.
- NVMe controller is dead after resume from S3, but not immediately, it's around 3 mins.
- Disable deepest power state (PS4) can still reproduce the issue.
- Disable APST before controller shutdown makes no difference.
- In addition to disabling APST, explicitly set power state to 0 before controller shutdown makes no difference.

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1705748
