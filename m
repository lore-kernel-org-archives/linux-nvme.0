Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D972C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 15:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:To:From:References:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DPcNcVYmy1qkxlz/nwuSebxNlLnIY3NSQF/CAZ8aV5c=; b=UESmapyVY0GXVeOOI7mHsZLSG0
	l88+x1CuUZcJ+JXVxOBTa+91/NyEkwkqoZ5sXEiytR4tKk/V+aY/7CIM+zDzQRcYzwzw/yq5ntxkX
	m35hsH4Xlv6H66chNKPiDAnKxy0HDc8IMtgyhcPC6bdyasEkCU0UvfU716Bg6IFqmZxrZrcN1otnj
	WsHMwfA1E4KwNcW417iyVc6SbrCz/2Yp7Xza2ObaEWIhegD/7ylBwrp2QWQKPvhi26pKfTRIWuJfU
	mDtCKWyo+EUHLyE8cto/hBPwvOOdHrcKRq3mxjgovneuIBffD5CwCZzQIkr/9rNh6hmr/6uGmhNLz
	2mukplGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nH5ZJ-00Ac9U-BW; Mon, 07 Feb 2022 15:04:41 +0000
Received: from forward500j.mail.yandex.net ([5.45.198.250])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nH5Yv-00Ac1U-4X
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 15:04:22 +0000
Received: from myt5-c010fd526357.qloud-c.yandex.net
 (myt5-c010fd526357.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:10ae:0:640:c010:fd52])
 by forward500j.mail.yandex.net (Yandex) with ESMTP id 08A536CB6B10
 for <linux-nvme@lists.infradead.org>; Mon,  7 Feb 2022 18:04:13 +0300 (MSK)
Received: from myt6-016ca1315a73.qloud-c.yandex.net
 (myt6-016ca1315a73.qloud-c.yandex.net [2a02:6b8:c12:4e0e:0:640:16c:a131])
 by myt5-c010fd526357.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 f2jDNARUP6-4Cd0aTre; Mon, 07 Feb 2022 18:04:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1644246252; bh=DPcNcVYmy1qkxlz/nwuSebxNlLnIY3NSQF/CAZ8aV5c=;
 h=In-Reply-To:From:Subject:References:Date:Message-ID:To;
 b=AwCmamHOrmp9SBE0iMTTkK2+o6ONKnhvzdPMQF8G6DDWangbVozC/YPYAoUPuLsuQ
 iPpdzM/ch+9/FqTNu3w1N29fWPY5+4ika+2Hr06RNfbb8iIBkerlThgohqx9XQQYty
 NmkXvM1Qi887hxG0e3CnBLK4d5XhLYemfgcVjFaQ=
Authentication-Results: myt5-c010fd526357.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by myt6-016ca1315a73.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id v56tokhmj8-4CI4Q1gA; Mon, 07 Feb 2022 18:04:12 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
X-Yandex-Fwd: 2
Message-ID: <02375891-2f92-c3d9-8a55-019b84c14c1c@yandex.ru>
Date: Mon, 7 Feb 2022 18:04:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: NVMe over Fabrics host: behavior on presence of ANA Group in
 "change" state
Content-Language: en-US
References: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
 <9a765265-0200-0eea-872f-780c4dbb69b8@grimberg.me>
From: Alex Talker <alextalker@yandex.ru>
To: linux-nvme <linux-nvme@lists.infradead.org>
In-Reply-To: <9a765265-0200-0eea-872f-780c4dbb69b8@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_070417_629653_D52CECD1 
X-CRM114-Status: GOOD (  56.58  )
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

 > I'm not exactly sure what you are trying to do, but it sounds
 > wrong... ANA groups are supposed to be a logical unit that expresses
 > controllers access state to the associated namespaces that belong to
 > the group.

I do agree that my setup might seem odd but I doubt it contradicts your 
statement much,
since each group would represent state of namespaces belonging to it,
the difference is just that instate of having a complex(or should I say 
one depending on installation/deployment)
relationship between a namespace and an ANA group, I opted for the 
balancing act between flexibility of assigning state for a namespace
and having a constant set of ANA groups on each system.
In my view, it is rather often situation when one namespace has troubles 
while others aren't and thus it better be unavailable on all ports at once,
rather than when certain port needs to deny access to certain namespaces 
for, say, maintenance issues.

 > That is an abuse of ANA groups IMO. But OK...

I do not disagree but so seems to do the standard.
But let me try to explain my perspective in possibly more familiar 
analogy to you.
As you probably aware, with ALUA in SCSI, via Target Port Groups 
mechanism, one can with zero worry specify certain LUN (ALUA) state on a 
set of targets(at least in SCST implementation).
I ain't sure about certain limitations but I think it's quite easy to 
keep up with 1 LUN = 1 group ratio for flexible control.
However, as I highlighter in earlier message, in nvmet implementation 
there's allowed only 128 ANA Groups, while (each!) subsystem may keep up 
to 1024 namespaces.
Thus, if I had no issue of say assigning a group per each 
namespace(assuming that NSIDs are globally unique on my target), this is 
currently not the case,
so I'm trying my best of out in these restrictions, while keeping ANA 
Group setup as straightforward, as possible.
One may argue that I shall dump everything into one ANA Group but it 
will contradict my expectations of High Availability of namespaces that 
are still (mostly?) working while others aren't.
One also may argue that it's rare to have in production greater number 
of namespaces than 128 in total but I still would prefer to go for 
support of 1024 anyway.
Hope I cleared that one out, do feel free to correct me if I have a flaw 
somewhere.

 > This state is not a permanent state, it is transient by definition,
 > which is why the host is treating it as such.
 >
 > The host is expecting the controller to send another ANA AEN that
 > notifies the new state within ANATT (i.e. stateA -> change ->
 > stateB).

As mentioned by Hannes, and I agree, state is indeed transient but only 
in relation to a namespace,
so I find it to be zero issue of having a group in change state with 0 
namespaces as its members.
I understand that it would be nice and dandy to change state of multiple 
namespaces at once(if one can take time to configure such dependency 
between them),
but I at the moment opt for simpler but flexible solution, maybe at the 
cost of greater number of ANA log changes in worst-case scenario.
Thus, the cycle "namespace in state A" => "namespace in state of change" 
=> "namespace in state B" is still preserved, tho with different 
methods(change of a group rather than a state of the group).

 > That is simply removing support for multipathing altogether.

You're not wrong on that one, tho, no offense, in certain configurations 
or certain initiators that's a way to go.
Especially when it might be a matter of changing one implementation to 
another(i.e. old good dm-multipath).
I mainly mentioned this because it fixes the issue on some 
kernels(including mainline/LTS) while not on others,
which is why I think it's important that misinterpretation of the 
standard will be accounted for on the mainstream code
since I can't possibly patch every single thing that lives on back-ports 
for it(I personally look at CentOS world rn),
while it might be the end user of my target setups.
My territory is mainly the target and this is not the issue I can fix on 
my side.
Besides, handling of my case differs from standard way anyway right now.

 > I'm still don't fully understand what you are trying to do, but
 > creating a transient ANA group for a change state sounds backwards to
 > me.

As I stated, I'm just trying to work with present limitations, which I 
suppose were chosen with regard to performance or something.

 > Could be... We'll need to see patches.

On that regard, I have seen plenty of git-related mails around here,
so would it be possible to publish patches as a few commits based on 
mainline or infradead git repo on GitHub or something?
Or is it mandatory to go, no offense, the old-fashioned way of sending 
patch files as attachments or text?
I just 99.9% work with git and the former will be easier for me.

Best regards,
Alex

On 07.02.2022 14:07, Sagi Grimberg wrote:
 >
 >
 > On 2/6/22 15:59, Alex Talker wrote:
 >> Recently I noticed a peculiar error after connecting from the host
 >> (CentOS 8 Stream at the time, more on that below) via TCP(unlikely
 >> matters) to the NVMe target subsystem shared using nvmet module:
 >>
 >>> ... nvme nvme1: ANATT timeout, resetting controller. nvme nvme1:
 >>> creating 8 I/O queues. nvme nvme1: mapped 8/0/0 default/read/poll
 >>> queues. ... nvme nvme1: ANATT timeout, resetting controller.
 >>> ...(and it continues like that over and over and over again, on
 >>> some configuration even getting worse with greater iterations of
 >>> reconnect)
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
 >> state or be a part of some transitioning process.
 >
 > I'm not exactly sure what you are trying to do, but it sounds
 > wrong... ANA groups are supposed to be a logical unit that expresses
 > controllers access state to the associated namespaces that belong to
 > the group.
 >
 >> Thus, the simplest scheme for me on each port is to assign few ANA
 >> Groups, one per each possible ANA state, and change ANA Group on a
 >> namespace rather than changing state of the group the namespace
 >> belongs to at the moment.
 >
 > That is an abuse of ANA groups IMO. But OK...
 >
 >> And here's the catch.
 >>
 >> If one creates a subsystem(no namespaces needed) on a port,
 >> connects to it and then sets state of ANA Group #1 to "change", the
 >> issue introduced in the beginning would be reproduced practically
 >> on many major distros and even upstream code without and issue,
 >
 > This state is not a permanent state, it is transient by definition,
 > which is why the host is treating it as such.
 >
 > The host is expecting the controller to send another ANA AEN that
 > notifies the new state within ANATT (i.e. stateA -> change ->
 > stateB).
 >
 >> tho sometimes it can be mitigated by disabling the "native
 >> multipath"(when /sys/module/nvme_core/parameters/multipath set to
 >> N) but sometimes that's not the case which is why this issue quite
 >> annoying for my setup.
 >
 > That is simply removing support for multipathing altogether.
 >
 >> I just checked it on 5.15.16 from Manjaro(basically Arch Linux) and
 >> ELRepo's kernel-ml and kernel-lt(basically vanilla versions of the
 >> mainline and LTS kernels respectively for CentOSs).
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
 >> while that might over-complicate usage of the module),
 >
 > I'm still don't fully understand what you are trying to do, but
 > creating a transient ANA group for a change state sounds backwards to
 > me.
 >
 >> on the other I think it happens to be a misinterpretation of the
 >> standard and might need some additional clarification.
 >>
 >> That's why I decided to compose this message first prior to
 >> proposing any patches.
 >>
 >> Also, while digging the code, I noticed that ANATT at the moment
 >> presented by a random constant(of 10 seconds), and since often
 >> transition time differs depending on block devices being in-use
 >> underneath namespaces, it might be viable to allow end-user to
 >> change this value via configfs.
 >
 > How would you expose it via configfs? ana groups may be shared via
 > different ports IIRC. You would need to prevent conflicting
 > settings...
 >
 >> Considering everything I wrote, I'd like to hear opinions on the
 >> following issues: 1. Whether my utilization of ANA Groups is viable
 >> approach?
 >
 > I don't think so, but I don't know if I understood what you are
 > trying to do.
 >
 >> 2. Which ANA Group assignment schemes utilized in production, from
 >> your experience?
 >
 > ANA groups will usually relate, a ANA group will be used for what it
 > is supposed to. A group of zero or more namespaces where each
 > controller may have different access state to it (or the namespaces
 > assigned to it).
 >
 >> 3. Whether changing ANATT value change should be allowed via
 >> configfs(in particular, on per-subsystem level I think)?
 >
 > Could be... We'll need to see patches.

