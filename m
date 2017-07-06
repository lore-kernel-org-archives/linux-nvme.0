From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 6 Jul 2017 09:41:22 +0300
Subject: [PATCH v3] nvme: split nvme_uninit_ctrl into stop and uninit
In-Reply-To: <20170705224150.GB24884@localhost.localdomain>
References: <1499286857-7657-1-git-send-email-sagi@grimberg.me>
 <20170705222502.GA24884@localhost.localdomain>
 <20170705224150.GB24884@localhost.localdomain>
Message-ID: <f707fc17-92bf-2ec7-00e3-251649a993d9@grimberg.me>


> Ah, it doesn't merge with your earlier patch, "nvme: move queue_count to
> the nvme_ctrl". That 8-patch series the conflict came from looks good too,
> so let's rebase this one on top of that.

It applies on v2 of my series.

I'll update nvme-4.13 (was waiting for James to ack)
