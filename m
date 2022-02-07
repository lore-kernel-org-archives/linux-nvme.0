Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54789C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:To:From:References:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NI59/bJCELJsOUJziWbBWYISl94A+1R4371SSlsyR60=; b=WIaQ63oPFi6oZthV1qfiLS3t1B
	U4YRIhOhSOKoA++HRB8U17dzBJI+0aAGf8FsUiHjEB5d5DcwvQpCtlXpL4WNJ2szyTXBNTjvJvybc
	LZmAWnHWZXkeJs/nkQBZnh9QgD4BMpxvbyOvhZOj9XrJd10Ut29C7KDzNiSKq2zUcCUt40XzMoUNa
	BO+DJ/pXp0pbDw4DZ4uKGLD2L+wIa68Y84+rYnmuqnJ3auyWoDPJQ2dJrnjmStp4NtC3O6F9LG/r9
	xoC1hUa4dVbU2RWLpdtaZQmesYLTNg4+KO1c8nGo3jiN8ZxXCmU3u27vBCimUMlTOaec+6fgJIgUL
	zmYISf0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nH5Yz-00Ac4K-M0; Mon, 07 Feb 2022 15:04:21 +0000
Received: from forward500o.mail.yandex.net ([37.140.190.195])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nH5Yu-00Ac0m-9n
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 15:04:20 +0000
Received: from iva8-4db386e07e2e.qloud-c.yandex.net
 (iva8-4db386e07e2e.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0c:951e:0:640:4db3:86e0])
 by forward500o.mail.yandex.net (Yandex) with ESMTP id 19ABD9414C0
 for <linux-nvme@lists.infradead.org>; Mon,  7 Feb 2022 18:04:09 +0300 (MSK)
Received: from iva8-a4a480c9f089.qloud-c.yandex.net
 (iva8-a4a480c9f089.qloud-c.yandex.net [2a02:6b8:c0c:da5:0:640:a4a4:80c9])
 by iva8-4db386e07e2e.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 btLVWLhL7Q-48cWhquo; Mon, 07 Feb 2022 18:04:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1644246249; bh=NI59/bJCELJsOUJziWbBWYISl94A+1R4371SSlsyR60=;
 h=In-Reply-To:From:Subject:References:Date:Message-ID:To;
 b=Rj7w0AXFMDeX5bTaEbkFGDWtMMYWva0k9BpDLAg6z2ybVtQB/M+P5kbyhC+361p5N
 G7z5n8Qb6lspackMpNVIR+sAwODhDfN5yfIIfPuoIpkaHnqNb8g2N8YpliYlWsK0/R
 5YOhbpS1qB6Lkhxkn+AmtoAWoj5eRv32aR7RVnAU=
Authentication-Results: iva8-4db386e07e2e.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by iva8-a4a480c9f089.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id z93WT9x8wc-48ISpP5g; Mon, 07 Feb 2022 18:04:08 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
X-Yandex-Fwd: 2
Message-ID: <1d08f5b3-1740-32bc-8d92-6ec476e0fd7a@yandex.ru>
Date: Mon, 7 Feb 2022 18:04:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: NVMe over Fabrics host: behavior on presence of ANA Group in
 "change" state
Content-Language: en-US
References: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
 <b800341f-b8f2-741b-1405-4dfcf888199e@suse.de>
From: Alex Talker <alextalker@yandex.ru>
To: linux-nvme <linux-nvme@lists.infradead.org>
In-Reply-To: <b800341f-b8f2-741b-1405-4dfcf888199e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_070416_928330_040224DC 
X-CRM114-Status: GOOD (  54.50  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks for the quick reply!

 > That's actually a misinterpretation. The above sentence refers to a
 > device reporting to be in ANA 'change', ie after reading the ANA log
 > and detecting that a given namespace is in a group whose ANA status
 > is 'change'.

Thus if I understand you correctly, you agree on behavior that the 
timer(ANATT)
shouldn't be started upon seeing an empty ANA Group (in "change" state)
but rather when at least one namespace belongs to a group in such state?

 > In your case it might be feasible to not report 'change' at all, but
 > rather do an direct transition from one group to the other. If it's
 > just a single namespace the transition should be atomic, and hence
 > there won't be any synchronisation issues which might warrant a
 > 'change' state.

While it might be possible, I think that sometimes "change" state might 
work as a sort of "I/O barrier"
when some changes on underlying block device might be in progress,
and in that case determining final state might not be that easy prior to 
the operation end.
Please, do feel free to correct me if that's an inappropriate usage!
I'm still interested to hear tho more details on what synchronization 
issues might arise as you mentioned?

 > Well, it certainly is an odd one, but should be doable. But note,
 > there had been some fixes to the ANA group ID handling; most recently
 > commit 79f528afa939 ("nvme-multipath: fix ANA state updates when a
 > namespace is not present"). So do ensure to have the latest fixes to
 > get the 'best' possible user-experience.

Well, i do agree that my approach is a tiny bit outstanding since I 
catch such bugs
but I checked the nvme.git on this platform and the code my setup has 
issues with is still there.
The commit you mentioned as I understood is made in regard to some race 
condition or alike,
which is by the way abstractly speaking might as well be an infinite 
loop if something goes awry
but I hope I won't ever met such an issue in production.

 > Typically it's the NVMe controller port which holds the ANA state;
 > for most implementation I'm aware of you have one or more (physical)
 > NVMe controller ports, which hosts the interfaces etc. They connect
 > to the actual storage, and failover is done by switching I/O between
 > those controller ports. Hence the ANA state is really property of
 > the controller port in those implementations.

So, in short, each port has just one group and all namespaces belong to it,
and thus all resources on the port change state at once?
I can agree that this is quite a simple setup in its own right too 
however I'm thinking more in dimension of
"what if one namespace becomes unavailable, how to efficiently change 
only its state without having an over-complicated ANA Group configuration?"
to be in foot with High Availability concept.
Of course I might have personalized ANA Group setup for each 
installation/deployment but I preferred to start with something simple 
yet flexible,
since standard doesn't exactly opposes an idea that change of ANA Group 
involves possible change of the ANA state for a namespace too.

 > The ANATT value is useful if you have an implementation which takes
 > some time to facilitate the switch-over. As there is always a chance
 > of the switch-over going wrong the ANATT serves as an upper boundary
 > after which an ANA state of 'change' can be considered stale, and a
 > re-read is in order. So for the linux implementation it's a bit
 > moot; one would have to present a use-case where changing the ANATT
 > value would make a difference.

I can't think much of any particular example at this moment but from my 
personal experience,
working with custom storage solutions on some operations might take 
quite a while,
and even standard gives an example with ANATT=30 which I think some kind 
of "magical constant"
from SCSI world where it needs to be customized from initiator's side in 
order for things to hang out a little more.
On this regard, I'm more thinking from the perspective of giving an 
administrator ability to customize the value if a need arises,
since I haven't had an idea of such value existing prior to catching my 
(in silly way triggered) error.
For example, I think some operations on DRBD devices might take quite 
reasonable amount of time,
and while we may argue on how useful DRBD in this setup anyway, I 
mentioned it purely for example purposes.
I'm sure eventually, possibly especially with releases of NVMe HDDs on 
the market,
real use-cases might be more often and I find implementing the 
customization prior to that quite useful.

Best regards,
Alex

On 07.02.2022 12:46, Hannes Reinecke wrote:
 > On 2/6/22 14:59, Alex Talker wrote:
 >> Recently I noticed a peculiar error after connecting from the host
 >> (CentOS 8 Stream at the time, more on that below) via TCP(unlikely
 >> matters) to the NVMe target subsystem shared using nvmet module:
 >>
 >>> ... nvme nvme1: ANATT timeout, resetting controller. nvme nvme1:
 >>> creating 8 I/O queues. nvme nvme1: mapped 8/0/0
 >>> default/read/poll queues. ... nvme nvme1: ANATT timeout,
 >>> resetting controller. ...(and it continues like that over and
 >>> over and over again, on some configuration even getting worse
 >>> with greater iterations of reconnect)
 >>
 >> I discovered that this behavior is caused by code in
 >> drivers/nvme/host/multipath.c, in particular when function
 >> nvme_update_ana_state increments value of variable nr_change_groups
 >> whenever any ANA Group is in "change", indifference of whether any
 >> namespace belongs to the group or not. Now, after figuring out that
 >> ANATT stands for ANA Transition Time and reading some more of the
 >> NVMe 2.0 standards, I understood that the problem caused by how I
 >> managed to utilize ANA Groups.
 >>
 >> As far as I remember, permitted number of ANA Groups in nvmet
 >> module is 128, while maximum number of namespaces is 1024(8 times
 >> more). Thus, mapping 1 namespace to 1 ANA Group works only up to a
 >> point. It is nice to have some logically-related namespaces belong
 >> to the same ANA Group, and the final scheme of how namespaces
 >> belong to ANA groups is often vendor-specific (or rather lies in
 >> decision domain of the end user of target-related stuff), However,
 >> rather than changing state of a namespace on specific port, for
 >> example for maintenance reasons, I find it particularly useful to
 >> utilize ANA Groups to change the state of a certain namespace,
 >> since it is more likely that block device might enter unusable
 >> state or be a part of some transitioning process. Thus, the
 >> simplest scheme for me on each port is to assign few ANA Groups,
 >> one per each possible ANA state, and change ANA Group on a
 >> namespace rather than changing state of the group the namespace
 >> belongs to at the moment. And here's the catch.
 >>
 >> If one creates a subsystem(no namespaces needed) on a port,
 >> connects to it and then sets state of ANA Group #1 to "change", the
 >> issue introduced in the beginning would be reproduced practically
 >> on many major distros and even upstream code without and issue, tho
 >> sometimes it can be mitigated by disabling the "native
 >> multipath"(when /sys/module/nvme_core/parameters/multipath set to
 >> N) but sometimes that's not the case which is why this issue quite
 >> annoying for my setup. I just checked it on 5.15.16 from
 >> Manjaro(basically Arch Linux) and ELRepo's kernel-ml and
 >> kernel-lt(basically vanilla versions of the mainline and LTS
 >> kernels respectively for CentOSs).
 >>
 >> The standard tells that:
 >>
 >>> An ANA Group may contain zero or more namespaces
 >>
 >> which makes perfect sense, since one has to create a group prior to
 >> assigning it to a namespace, and then:
 >>
 >>> While ANA Change state is reported by a controller for the
 >>> namespace, the host should: ...(part regarding ANATT)
 >>
 >> So on one hand I think my setup might be questionable(I might
 >> allocate ANAGRPID for "change" only in times of actual transitions,
 >> while that might over-complicate usage of the module), on the other
 >> I think it happens to be a misinterpretation of the standard and
 >> might need some additional clarification.
 >>
 > That's actually a misinterpretation. The above sentence refers to a
 > device reporting to be in ANA 'change', ie after reading the ANA log
 > and detecting that a given namespace is in a group whose ANA status
 > is 'change'.
 >
 > In your case it might be feasible to not report 'change' at all, but
 > rather do an direct transition from one group to the other. If it's
 > just a single namespace the transition should be atomic, and hence
 > there won't be any synchronisation issues which might warrant a
 > 'change' state.
 >
 >> That's why I decided to compose this message first prior to
 >> proposing any patches.
 >>
 >> Also, while digging the code, I noticed that ANATT at the moment
 >> presented by a random constant(of 10 seconds), and since often
 >> transition time differs depending on block devices being in-use
 >> underneath namespaces, it might be viable to allow end-user to
 >> change this value via configfs.
 >>
 >> Considering everything I wrote, I'd like to hear opinions on the
 >> following issues: 1. Whether my utilization of ANA Groups is viable
 >> approach?
 >
 > Well, it certainly is an odd one, but should be doable. But note,
 > there had been some fixes to the ANA group ID handling; most recently
 > commit 79f528afa939 ("nvme-multipath: fix ANA state updates when a
 > namespace is not present"). So do ensure to have the latest fixes to
 > get the 'best' possible user-experience.
 >
 >> 2. Which ANA Group assignment schemes utilized in production, from
 >> your experience?
 >
 > Typically it's the NVMe controller port which holds the ANA state;
 > for most implementation I'm aware of you have one or more (physical)
 > NVMe controller ports, which hosts the interfaces etc. They connect
 > to the actual storage, and failover is done by switching I/O between
 > those controller ports. Hence the ANA state is really property of
 > the controller port in those implementations.
 >
 >> 3. Whether changing ANATT value change should be allowed via
 >> configfs(in particular, on per-subsystem level I think)?
 >>
 > The ANATT value is useful if you have an implementation which takes
 > some time to facilitate the switch-over. As there is always a chance
 > of the switch-over going wrong the ANATT serves as an upper boundary
 > after which an ANA state of 'change' can be considered stale, and a
 > re-read is in order. So for the linux implementation it's a bit
 > moot; one would have to present a use-case where changing the ANATT
 > value would make a difference.
 >
 > Cheers,
 >
 > Hannes

