From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 20 Aug 2018 13:52:08 -0700
Subject: [PATCH 0/2] nvme-discover: Use 'nvme_info' sysfs attribute for fc
 transport
In-Reply-To: <20180820103407.92783-1-hare@suse.de>
References: <20180820103407.92783-1-hare@suse.de>
Message-ID: <c2e38690-cbc1-d872-310f-530b1e4ccdc3@grimberg.me>


> Hi all,
> 
> here's a small patchset to use the 'nvme_info' sysfs attribute from the SCSI
> host to provide the parameters for 'nvme discover'.
> So with this patch it's sufficient to state
> 
> nvme discover -t fc
> 
> and all discovery log entries are returned.

Using arbitrary nvme info from scsi lpfc implementation is not going to
work... We need something that can be more generic and bound within
nvme.

Besides, fc already has udev infra to auto connect IIRC.
