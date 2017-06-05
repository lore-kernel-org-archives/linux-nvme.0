From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Jun 2017 14:09:00 +0300
Subject: [PATCH V2] nvme: fix nvme_remove going to uninterruptible sleep
 for ever
In-Reply-To: <20170605105217.GA31313@dhcp-216.srv.tuxera.com>
References: <20170530071610.GA2679@hercules.tuxera.com>
 <4da7c939-1f54-80e5-48fc-06e58e14f018@grimberg.me>
 <20170530142346.GA39428@dhcp-216.srv.tuxera.com>
 <20170601114338.GA24855@lst.de>
 <bb2780a8-63af-4d58-6c78-b03152de0439@grimberg.me>
 <20170605081817.GA22122@lst.de>
 <20170605105217.GA31313@dhcp-216.srv.tuxera.com>
Message-ID: <0666b909-e1a0-1a18-8800-b81a230de25a@grimberg.me>

Rakesh,

> I would post a new patch which includes my RESETTING state earlier
> patch + the cancel_work_sync which Sagi suggested after testing.
> 
> Sagi: Because my RESETTING patch earlier is subset of your untested
> patch with cancel_work_sync, it would be logical to take a signed off
> from you as well.  May you review/ack/nack the patch?  Feel free to
> let me know if you want me to change it further or instead you want to
> post as author.

Its all yours :)

send a patch and we'll review it, thanks.
