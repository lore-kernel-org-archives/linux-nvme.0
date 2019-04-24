From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Apr 2019 09:55:16 -0700
Subject: [PATCH v2 0/2] Adding per-controller timeout support to nvme
In-Reply-To: <20190403123506.122904-1-mheyne@amazon.de>
References: <20190403123506.122904-1-mheyne@amazon.de>
Message-ID: <fb33a464-af65-abec-5ff1-15925e7669a4@grimberg.me>


> As different nvme controllers are connect via different fabrics, some require
> different timeout settings than others. This series implements per-controller
> timeouts in the nvme subsystem which can be set via sysfs.

How much of a real issue is this?

block io_timeout defaults to 30 seconds which are considered a universal
eternity for pretty much any nvme fabric. Moreover, io_timeout is
mutable already on a per-namespace level.

This leaves the admin_timeout which goes beyond this to 60 seconds...

Can you describe what exactly are you trying to solve?
