From: indraneel.m@samsung.com (Indraneel Mukherjee)
Date: Wed, 17 Sep 2014 18:02:16 +0530
Subject: Question on IOStat accounting
Message-ID: <067e01cfd273$76dbc4e0$64934ea0$@samsung.com>

In the current implementation of IO accounting in the nvme driver,
accounting is started once IOD is successfully prepared.
Thereafter 2 cases can happen, either IO gets successfully submitted to
device or it can get queued up in the IOD list if there is a failure.

So what's the definition of iostat here? In-flight in the device or
in-flight in the driver ? Is there a need to make this consistent?

-Indro
