From: me@joshuabonnett.com (Joshua Bonnett)
Date: Mon, 15 Jan 2018 12:15:24 -0800
Subject: 960 evo + APST
In-Reply-To: <cbdc65ead10e41efbba41efcb0d56fa6@ausx13mpc120.AMER.DELL.COM>
References: <1516014692.300.1235638048.4627AF31@webmail.messagingengine.com>
 <9AA08A54-06CB-4EF3-BD46-74456C276496@canonical.com>
 <cbdc65ead10e41efbba41efcb0d56fa6@ausx13mpc120.AMER.DELL.COM>
Message-ID: <1516047324.791152.1236256824.1B154A54@webmail.messagingengine.com>

Oh, I hadn't seen 1.7.0. I am on 1.5.0.  I will update and report back.

I had been looking at adding the 9560 to the same quirks if statement as the 9550, however, I have APST disabled after trying to set the default_ps_max_latency_us to 2000 still resulted in crashes. I do realize turning APST off on a laptop is undesirable, but I thought it a better compromise than crashing. 

The attached information was taken with nvme_core.default_ps_max_latency_us=0. I will run the bios update and remove the boot arguments and run nvme get-feature again, then go use one of my other computers for work today so that this one has a chance to hit that deep power savings level.


On Mon, Jan 15, 2018,@9:28 AM, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Kai Heng Feng [mailto:kai.heng.feng at canonical.com]
> > Sent: Monday, January 15, 2018 5:18 AM
> > To: Joshua Bonnett <me at joshuabonnett.com>
> > Cc: hch at lst.de; Limonciello, Mario <Mario_Limonciello at Dell.com>; linux-nvme
> > <linux-nvme at lists.infradead.org>
> > Subject: Re: 960 evo + APST
> > 
> > >
> > > On 15 Jan 2018,@7:11 PM, Joshua Bonnett <me@joshuabonnett.com> wrote:
> > >
> > > Really sorry to bother you guys, I am trying to nail down the pm961/sm961/ 960
> > evo APST bug and I have a dell xps 15 9560 here with a pm961 and it needed APST
> > turned off completely as well and not just turned down. I am just wondering if you
> > tested the 960 evo throughly in any other motherboards or laptops?   Thanks!
> > 
> > Do you mean that disabling PS4 doesn?t help?
> > 
> > Disable APST completely is not desirable for a laptop.
> > 
> > Please attach the output of `sudo nvme get-feature -f 0x0c -H /dev/nvme0`
> > and `sudo nvme id-ctrl /dev/nvme0`, thanks.
> > 
> > Kai-Heng
> > 
> > >
> > >
> > > (let me know if you want me to just leave you be, and I will just wander off to buy
> > some drives or something, no hard feelings)
> 
> Joshua,
> 
> I had heard that 9550 and 9560 should both be affected by the same 
> problem, but 9560
> less severe.
> 
> The quirks in kernel don't actually turn down 9560 / Precision 5520 
> though.  They currently
> only apply to XPS 9550/ Precision 5510.  Were you manually setting 
> something to prevent
> going into PS4?
> 
> Furthermore, can you please share your BIOS version?  Have you updated 
> to the latest one
> already?  There are supposed to be BIOS mitigations for this problem 
> too.
> 
> The latest one is available on LVFS (1.7.0).
> https://fwupd.org/lvfs/device/34578c72-11dc-4378-bc7f-b643866f598c
> 
> Thanks,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: nvme_id-ctrl
Type: application/octet-stream
Size: 1318 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180115/cd84b0b6/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: nvme_feature
Type: application/octet-stream
Size: 4538 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180115/cd84b0b6/attachment-0001.obj>
