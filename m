Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AAFC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:To:From:References:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BgRqdVirKeL+LgRTBd260KcpnlR2rYJd+zrF6qBXU2s=; b=LJfm4kKJsoYsGJJq69TUthornd
	i6PDIlMlR5SlrhRi8DfSbzLBWQoHupFSn9X2csw4lavgjjdeu8MDhAsMoB1UgIMoOdvagDCaYR5dm
	GcI0rshbl0Z1cBmxRoslGK8vSEe1io34QzGFGN6osUgXnJ/ZDvhFmY2KzkKIs34Q0FoD6uThESOWz
	3eQQR4mVSjwVRh1+hMvS97e6nC+1Jz9+C7PgyQrxhJgxjENDO74pU93xx4E5B8l8MtelbPX/TAZkk
	D5JZ3Y3Mebcc8kVX3VIwuQBuAj/MR39P0/V+WS7txlT3hJvI9Yqp/UORKzXbZrqSWxfEYUzphRdx8
	+1qZ9irQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nI9mm-003wzG-3M; Thu, 10 Feb 2022 13:47:00 +0000
Received: from forward500o.mail.yandex.net ([37.140.190.195])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nI9mh-003wy1-Ds
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 13:46:58 +0000
Received: from vla1-2a93b1d0b0e8.qloud-c.yandex.net
 (vla1-2a93b1d0b0e8.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:1e22:0:640:2a93:b1d0])
 by forward500o.mail.yandex.net (Yandex) with ESMTP id CDDB3942523
 for <linux-nvme@lists.infradead.org>; Thu, 10 Feb 2022 16:46:46 +0300 (MSK)
Received: from vla3-23c3b031fed5.qloud-c.yandex.net
 (vla3-23c3b031fed5.qloud-c.yandex.net [2a02:6b8:c15:2582:0:640:23c3:b031])
 by vla1-2a93b1d0b0e8.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 fanICpAKNg-kkdiY3Yk; Thu, 10 Feb 2022 16:46:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1644500806; bh=BgRqdVirKeL+LgRTBd260KcpnlR2rYJd+zrF6qBXU2s=;
 h=In-Reply-To:From:Subject:References:Date:Message-ID:To;
 b=pZLpaNvQcGYOcjEye1qy7Bm1db+ZzKaSMMlq+tNKx6x0uAkjVRIwP8ZU3Ns2yL2i3
 dnA7nEOYatPEMWXFRYQLb/vlnE9lIcZEdDO5RlzYwu+/faG3AtpGxoSzGGFhO4Q2DD
 filqtRViGvVmHvVO9qs8maEV9cSns5cCGvxi1anw=
Authentication-Results: vla1-2a93b1d0b0e8.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by vla3-23c3b031fed5.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id 0TItPfQCaa-kkISsjGm; Thu, 10 Feb 2022 16:46:46 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
X-Yandex-Fwd: 2
Message-ID: <5b5cfff7-6c07-0cb1-491a-0fa3d13c2cbd@yandex.ru>
Date: Thu, 10 Feb 2022 16:46:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: NVMe over Fabrics host: behavior on presence of ANA Group in
 "change" state
Content-Language: en-US
References: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
 <9a765265-0200-0eea-872f-780c4dbb69b8@grimberg.me>
 <02375891-2f92-c3d9-8a55-019b84c14c1c@yandex.ru>
 <205b91c3-4da1-744d-3d06-ccfdf2b93cff@grimberg.me>
From: Alex Talker <alextalker@yandex.ru>
To: linux-nvme <linux-nvme@lists.infradead.org>
In-Reply-To: <205b91c3-4da1-744d-3d06-ccfdf2b93cff@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_054656_039840_606AEC81 
X-CRM114-Status: GOOD (  21.13  )
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

 > Can you please stop top-posting, its difficult to follow this
 > copy-pasting-top-posting chain that you are generating..

My bad, I just had a hard time taming my mail client in all this 
plain-text mode requirements.
Also, I was a bit confused on how to handle branching-off replies :)


In short, my opinion, after consulting with NVMe base specification 2.0b 
stating is that:

a) (8.1.2, page 340) "Namespaces that are members of the same ANA Group 
perform identical asymmetric namespace accessstate transitions.
The ANA Group maintains the same asymmetric namespace access state for 
allnamespaces that are members of thatANA Group
[...]The method for assigning namespacesto ANA Groups is outside the 
scope ofthisspecification."
b) (8.1.2, page 340) "An ANA Group may contain zero or more 
namespaces[...]The mapping of namespaces,[...] to ANA Groups is vendor
specific."
c) (Figure 280, page 270) "ANAGRPID[...]
If the value in this field changes and Asymmetric Namespace Access 
ChangeNotices are supported and enabled,
then the controller shall issue an AsymmetricNamespace Access Change 
Notice."
d) (8.1.3.5, page 343) "While ANA Change state is reported by a 
controller for the namespace, the host should:[...part about ANATT...]"

Thus I see it that ANATT-based timer should be started only upon 
condition that a namespace belongs to a group in this state
but change of relation between a namespace and it's ANA state can occur 
either because ANA Group state has changes(and this would affect all of 
the group members)
or when ANAGRPID is changed(and this, if the new group's ANA state 
differs from the old one, affects only one namespace at a time).
 From that, I find it is logical to no-op on the empty ANA Groups in 
"change" state since I don't see the standard explicitly disallowing 
that behavior in any way whatsoever.

Now, moving to the rest...

 > If your use-case needs more than 128 groups, you can send a patch.

I thought these constants were defined by optimization or something but 
I ain't no expert on the code base :)
In that case, what is your opinion on adding number of groups & 
namespaces as module parameters(to nvmet) alike "mulipath"(i.e. to be 
only set upon the load)?
As I saw in earlier discussion here on different matter, in production 
there's systems which provide huge number of namespace(and possibly 
groups too)
and this extra parameters would allow for easy mock-up of such setups to 
look for bottleneck and the like, without re-patching the code for each try.
Would appreciate your advice on possible disadvantages of such an approach!

 > nvmet is actually violating the spec right now because it doesn't
 > set bit 6 in ctrl identify anacap, and it clearly exposes anagrpid as
 > a config knob, so either we need to block it, or set that bit.

So, my "expertise" is lacking on this one but if I get what you saying 
correctly,
it means that for past hell knows how much time I could change the ANA 
group on target, AEN(I think? the notification functionality I mean) 
would be successfully sent
and hosts were quite okay with what's going on but somebody forgot to 
advertise such capability in the controller's info?
I literally used my workaround on these pre-"native multipath" host 
times(I'm looking on CentOS 7 for example) and it seem to went okay, so 
I'd vote for the bit.
So...this is like +1-2 patch(-es)?

 > No attachments please, follow the instructions in:
 > Documentation/process/submitting-patches.rst

Gotcha, already working on it.
I tested the straightforward patch on the latest release and it seems to 
be working as expected
(i.e. ANATT triggers only on on non-empty "change" state groups), so I'm 
on the stage of trying out the 'git send-email' :)

Thanks for your time anyway!

Best regards,
Alex

