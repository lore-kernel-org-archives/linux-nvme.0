From: kai.heng.feng@canonical.com (Kai-Heng Feng)
Date: Wed, 20 Sep 2017 11:15:42 +0800
Subject: Samsung SSD 960 EVO 500GB S3 issue
Message-ID: <CAAd53p4FfQ+L0J4-TuMqPLaOTs1i9afEHKA_tof+ZN6R6dn=Tw@mail.gmail.com>

Hi Judy,

Just found that Andy reached to you, apology for doing the same.

Here's another Samsung NVMe bug [1], this time it's not about PS4. Can
you take a look?

A quick summary:
- The user runs a Ryzen desktop.
- A quick google shows that firmware version 2B7QCXE7 is already latest.
- NVMe controller is dead after resume from S3, but not immediately,
it's around 3 mins.
- Disable deepest power state (PS4) can still reproduce the issue.
- Disable APST before controller shutdown makes no difference.
- In addition to disabling APST, explicitly set power state to 0
before controller shutdown makes no difference.

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1705748
