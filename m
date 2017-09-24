From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 24 Sep 2017 18:20:16 +0300
Subject: [PATCH rfc] nvme-cli: NVMf auto discovery systemd service
In-Reply-To: <20170924145605.GB14806@lst.de>
References: <1506258095-15916-1-git-send-email-sagi@grimberg.me>
 <20170924145605.GB14806@lst.de>
Message-ID: <7a11c982-808c-5113-3302-2673e4cdcec4@grimberg.me>

> This looks reasoanable to me, although I'm really not the expert
> for systemd stuff.

Me neither, Hence the RFC...

> Does it handle the case where /etc/nvme/discovery.conf is non-existent
> (yes, you created in the specfile, but not everyone uses rpms).

Well, it will fail the nvme connect-all command, which would appear
in the journal and disable the service, the user is expected to
add discovery.conf and re-enable the service at that point...

>> We can also add some documentation into discovery.conf to help
>> the user add discovery endpoints.
> 
> That would be great for the default one, e.g. some example RDMA
> and FC configfs.

I think James was pushing udev stuff for auto connection as FC
discovery is in-band, so not sure how this will apply to FC...
