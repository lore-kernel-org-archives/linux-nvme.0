From: kai.heng.feng@canonical.com (Kai-Heng Feng)
Date: Mon, 22 May 2017 17:04:15 +0800
Subject: NVMe APST high latency power states being skipped
Message-ID: <CAAd53p5pxgO-n0K4khAsYAcWw64tNJwtPwbMHaPksVQMLeXJmA@mail.gmail.com>

Hi Andy,

Currently, if a power state tradition requires high latency, it may be
skipped [1] based on the value of ps_max_latency_us in
nvme_configure_apst():

if (total_latency_us > ctrl->ps_max_latency_us)
    continue;

Right now ps_max_latency_us defaults to 25000, but some consumer level
NVMe have much higher latency.
I understand this value is configurable, but I am wondering if it's
possible to ignore the latency on consumer devices, probably based on
chassis type, so consumer devices can get most NVMe power saving out
of the box?

Thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/tree/drivers/nvme/host/core.c?h=nvme/power#n1396
