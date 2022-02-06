Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81724C433EF
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Feb 2022 14:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:From:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5l0TI4cP8v0K+e70B9XwyqbMotEp4FBZGdx4sZyy4cw=; b=yQzBffudLmkF0L4VBgPQjTS4FL
	DdKQ35bdQehxFRWxj/GyhPyBojXy87bl63CzQzTtMvSmiCnHmwNC9VGpfPIxWhgkW0sY1fL+YSLVD
	zniNAgvAwXW/bt2piQAMFyywn5JT8uaH8cnLJwc+keILwOzfaAXx+mhm74r9Mq/EwBE2VWVjPE4SM
	AZNDTijsxkNtShCw0tDR8uG9/K2ZbBsgrAKAqTvq8qzDoO9Q17JaHBA1PEZ2gRDpFF7nk6VuRo2bj
	iAqdMAtrXKyJwkf/zqCdMFQftn5xYmQ40WIooiOig9ZKak0PqeV0QeU1UgFAgNRCRyi70hNqIJUJl
	aeWsIT9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nGi6b-008H39-Ll; Sun, 06 Feb 2022 14:01:29 +0000
Received: from forward108j.mail.yandex.net ([2a02:6b8:0:801:2::253])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nGi6V-008Gzc-U8
 for linux-nvme@lists.infradead.org; Sun, 06 Feb 2022 14:01:25 +0000
Received: from myt5-e6ee94481288.qloud-c.yandex.net
 (myt5-e6ee94481288.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:5714:0:640:e6ee:9448])
 by forward108j.mail.yandex.net (Yandex) with ESMTP id 52F233F200CA
 for <linux-nvme@lists.infradead.org>; Sun,  6 Feb 2022 17:01:16 +0300 (MSK)
Received: from myt6-9bdf92ffd111.qloud-c.yandex.net
 (myt6-9bdf92ffd111.qloud-c.yandex.net [2a02:6b8:c12:468a:0:640:9bdf:92ff])
 by myt5-e6ee94481288.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 gxd0cURLvq-1GciXgKH; Sun, 06 Feb 2022 17:01:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1644156076; bh=5l0TI4cP8v0K+e70B9XwyqbMotEp4FBZGdx4sZyy4cw=;
 h=Subject:From:Date:Message-ID:To;
 b=RrAW1keXiPkubEnpLbP2fkucT7SsWYx1wzEmc6u62T0T5tdsl4iqCxwCuHeQGyAEY
 dmefj3OgyDeEMOe3tEdH9ALiTUwy3kLbwU/PreFor/CTUMUHVoB+Ru5UCkJYoST5tl
 uACBhQzXoP8kGewmzVACqYSFgAW/FxC7AFnv8ssA=
Authentication-Results: myt5-e6ee94481288.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by myt6-9bdf92ffd111.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id 54MdtJogL9-1FHW4Pkq; Sun, 06 Feb 2022 17:01:15 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
X-Yandex-Fwd: 2
Message-ID: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
Date: Sun, 6 Feb 2022 16:59:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From: Alex Talker <alextalker@yandex.ru>
Subject: NVMe over Fabrics host: behavior on presence of ANA Group in "change"
 state
To: linux-nvme <linux-nvme@lists.infradead.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220206_060124_341524_9D8E9BB7 
X-CRM114-Status: GOOD (  20.74  )
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

Recently I noticed a peculiar error after connecting from the host
(CentOS 8 Stream at the time, more on that below)
via TCP(unlikely matters) to the NVMe target subsystem shared using 
nvmet module:

 > ...
 > nvme nvme1: ANATT timeout, resetting controller.
 > nvme nvme1: creating 8 I/O queues.
 > nvme nvme1: mapped 8/0/0 default/read/poll queues.
 > ...
 > nvme nvme1: ANATT timeout, resetting controller.
 > ...(and it continues like that over and over and over again, on some 
configuration even getting worse with greater iterations of reconnect)

I discovered that this behavior is caused by code in 
drivers/nvme/host/multipath.c,
in particular when function nvme_update_ana_state increments value of 
variable nr_change_groups whenever any ANA Group is in "change",
indifference of whether any namespace belongs to the group or not.
Now, after figuring out that ANATT stands for ANA Transition Time and 
reading some more of the NVMe 2.0 standards, I understood that the 
problem caused by how I managed to utilize ANA Groups.

As far as I remember, permitted number of ANA Groups in nvmet module is 
128, while maximum number of namespaces is 1024(8 times more).
Thus, mapping 1 namespace to 1 ANA Group works only up to a point.
It is nice to have some logically-related namespaces belong to the same 
ANA Group,
and the final scheme of how namespaces belong to ANA groups is often 
vendor-specific
(or rather lies in decision domain of the end user of target-related stuff),
However, rather than changing state of a namespace on specific port, for 
example for maintenance reasons,
I find it particularly useful to utilize ANA Groups to change the state 
of a certain namespace, since it is more likely that block device might 
enter unusable state or be a part of some transitioning process.
Thus, the simplest scheme for me on each port is to assign few ANA 
Groups, one per each possible ANA state, and change ANA Group on a 
namespace rather than changing state of the group the namespace belongs 
to at the moment.
And here's the catch.

If one creates a subsystem(no namespaces needed) on a port, connects to 
it and then sets state of ANA Group #1 to "change", the issue introduced 
in the beginning would be reproduced practically on many major distros 
and even upstream code without and issue,
tho sometimes it can be mitigated by disabling the "native 
multipath"(when /sys/module/nvme_core/parameters/multipath set to N) but 
sometimes that's not the case which is why this issue quite annoying for 
my setup.
I just checked it on 5.15.16 from Manjaro(basically Arch Linux) and 
ELRepo's kernel-ml and kernel-lt(basically vanilla versions of the 
mainline and LTS kernels respectively for CentOSs).

The standard tells that:

 > An ANA Group may contain zero or more namespaces

which makes perfect sense, since one has to create a group prior to 
assigning it to a namespace, and then:

 > While ANA Change state is reported by a controller for the namespace, 
the host should: ...(part regarding ANATT)

So on one hand I think my setup might be questionable(I might allocate 
ANAGRPID for "change" only in times of actual transitions, while that 
might over-complicate usage of the module),
on the other I think it happens to be a misinterpretation of the 
standard and might need some additional clarification.

That's why I decided to compose this message first prior to proposing 
any patches.

Also, while digging the code, I noticed that ANATT at the moment 
presented by a random constant(of 10 seconds), and since often 
transition time differs depending on block devices being in-use 
underneath namespaces,
it might be viable to allow end-user to change this value via configfs.

Considering everything I wrote, I'd like to hear opinions on the 
following issues:
1. Whether my utilization of ANA Groups is viable approach?
2. Which ANA Group assignment schemes utilized in production, from your 
experience?
3. Whether changing ANATT value change should be allowed via configfs(in 
particular, on per-subsystem level I think)?

Thanks for reading till the very end! Hope I didn't ramble too much, I 
just wanted to only lay out all of the details.

Best regards,
Alex

