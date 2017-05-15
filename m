From: oza.oza@broadcom.com (Oza Oza)
Date: Mon, 15 May 2017 14:04:48 +0530
Subject: [RFC] NVMe Configuraiton using sysctl
Message-ID: <CAMSpPPcxWYtZMbAc4TWam3iC1cLbxBPM=EhNPKA6qweiGnJvVg@mail.gmail.com>

Hi,

we are configuring interrupt coalesce for NVMe, but right now, it uses
module param.
so the same interrupt coalesce settings get applied for all the NVMEs
connected to different RCs.

ideally it should be with sysctl.
for e.g.
sysctl should provide interface to change
Per-CPU IO queue pairs, interrupt coalesce settings etc..

please suggest if we could have/implement sysctl module for NVMe ?

Regards,
Oza.
