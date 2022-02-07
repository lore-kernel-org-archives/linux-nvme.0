Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E93DC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 22:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yYsJmfmVxnZ9+mERDtZ1ubeHNvYJF/b7AAP47jnWP8k=; b=qqtJ3KCBLfvkUQC9O9ebp8GsUC
	zywpsuJlMOuxIqZZlkFBjDa58bIZxiOxZbDYZy1m41rIrph+hFNWr1L3eL2eUD5V4N1glk8tx2u70
	osvE4M8Qc1UIbaKb9X3wr0Hl3z4N3E08Cm5e1hb4BaYY7cNi4vcHwb+cs+7x48Gqx7q2AgjFRh/ue
	NVRcsLVxVJwW2dmyr6QAi+jiTtmGgdu9tg/L1XBsEIfypXP6AaXegA/q1aBHFZxVVpxquBAHEb6s7
	SouotghIWR1U+M4dRLL3kMWfP2oWqfsISg4bwLLi4sV72mSgIEKKVuVxe8KoIJUg+v+GJwcg+G2bZ
	KNuq347Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHCIs-00Bql8-Ev; Mon, 07 Feb 2022 22:16:10 +0000
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHCIo-00Bqji-Gu
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 22:16:09 +0000
Received: by mail-ej1-f53.google.com with SMTP id st12so21444361ejc.4
 for <linux-nvme@lists.infradead.org>; Mon, 07 Feb 2022 14:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=yYsJmfmVxnZ9+mERDtZ1ubeHNvYJF/b7AAP47jnWP8k=;
 b=4RFoa3lPaM6pO+5dwS5B/5dnQFvyaKizhHmgUxnjHDOkj7KzR1o8h0pAoAmrfLQMur
 ixFY66EdrZRYGdPSnNTQmXev0fqM2x1F9JqLcGEiJPPeDfaV6ZLFIRdETpHcZqZa8gUH
 rwmSL+R4A8mBUMH01ZDeFhAHzFFUbJSNRG8TBdMdGOn9S2mJJv3Yj2rqT4KmIZ+dvotR
 Y57pjuR/aCN3HbcYR+W8dI9qYS/3/5z1H0lGrObO2oVJwwnwY4FUv9oWenQm0KhE2ay9
 MA9mw3KJ0lLe3+vf51xZhZCI2K3xkvfN/otYJ/vgyVjVeoMiFVJhdX+bP3VZZdDdzwZn
 Zdzw==
X-Gm-Message-State: AOAM531uAK4g56U0frsjOa6vHLjNpxpgHldctn5YpfelhpjRuIMr70Dc
 65sB0TNfNrGMzoz2kfzs+ro7OCzvW8M=
X-Google-Smtp-Source: ABdhPJxKu4m1+ISyw9aiQCWQkxPIhk9eR4FNw+ioMl7wcuoOAaoM4nEpc958TtG7PL7Rs6LPhMZgiQ==
X-Received: by 2002:a17:907:a0c9:: with SMTP id
 hw9mr1330514ejc.421.1644272163593; 
 Mon, 07 Feb 2022 14:16:03 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id jz17sm4086582ejb.195.2022.02.07.14.16.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Feb 2022 14:16:03 -0800 (PST)
Message-ID: <205b91c3-4da1-744d-3d06-ccfdf2b93cff@grimberg.me>
Date: Tue, 8 Feb 2022 00:16:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: NVMe over Fabrics host: behavior on presence of ANA Group in
 "change" state
Content-Language: en-US
To: Alex Talker <alextalker@yandex.ru>,
 linux-nvme <linux-nvme@lists.infradead.org>
References: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
 <9a765265-0200-0eea-872f-780c4dbb69b8@grimberg.me>
 <02375891-2f92-c3d9-8a55-019b84c14c1c@yandex.ru>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <02375891-2f92-c3d9-8a55-019b84c14c1c@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_141606_612068_5B4DB1BD 
X-CRM114-Status: GOOD (  47.99  )
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

Alex,

Can you please stop top-posting, its difficult to follow this
copy-pasting-top-posting chain that you are generating..

>  > I'm not exactly sure what you are trying to do, but it sounds
>  > wrong... ANA groups are supposed to be a logical unit that expresses
>  > controllers access state to the associated namespaces that belong to
>  > the group.
> 
> I do agree that my setup might seem odd but I doubt it contradicts your 
> statement much,
> since each group would represent state of namespaces belonging to it,
> the difference is just that instate of having a complex(or should I say 
> one depending on installation/deployment)
> relationship between a namespace and an ANA group, I opted for the 
> balancing act between flexibility of assigning state for a namespace
> and having a constant set of ANA groups on each system.
> In my view, it is rather often situation when one namespace has troubles 
> while others aren't and thus it better be unavailable on all ports at once,
> rather than when certain port needs to deny access to certain namespaces 
> for, say, maintenance issues.

Not exactly sure what you are alluding to. I didn't suggest anything
about any static configuration. I was just explaining what ANA groups
are expressing. They're there, you are free to use them however you
like.

>  > That is an abuse of ANA groups IMO. But OK...
> 
> I do not disagree but so seems to do the standard.

The standard abuses ANA groups?

> But let me try to explain my perspective in possibly more familiar 
> analogy to you.
> As you probably aware, with ALUA in SCSI, via Target Port Groups 
> mechanism, one can with zero worry specify certain LUN (ALUA) state on a 
> set of targets(at least in SCST implementation).
> I ain't sure about certain limitations but I think it's quite easy to 
> keep up with 1 LUN = 1 group ratio for flexible control.
> However, as I highlighter in earlier message, in nvmet implementation 
> there's allowed only 128 ANA Groups, while (each!) subsystem may keep up 
> to 1024 namespaces.

If your use-case needs more than 128 groups, you can send a patch.

> Thus, if I had no issue of say assigning a group per each 
> namespace(assuming that NSIDs are globally unique on my target), this is 
> currently not the case,
> so I'm trying my best of out in these restrictions, while keeping ANA 
> Group setup as straightforward, as possible.
> One may argue that I shall dump everything into one ANA Group but it 
> will contradict my expectations of High Availability of namespaces that 
> are still (mostly?) working while others aren't.

I don't understand where HA/multipathing come into play here at all, let
alone asymmetric access. But it doesn't really matter.

> One also may argue that it's rare to have in production greater number 
> of namespaces than 128 in total but I still would prefer to go for 
> support of 1024 anyway.
> Hope I cleared that one out, do feel free to correct me if I have a flaw 
> somewhere.
> 
>  > This state is not a permanent state, it is transient by definition,
>  > which is why the host is treating it as such.
>  >
>  > The host is expecting the controller to send another ANA AEN that
>  > notifies the new state within ANATT (i.e. stateA -> change ->
>  > stateB).
> 
> As mentioned by Hannes, and I agree, state is indeed transient but only 
> in relation to a namespace,

Where did you get that from the spec? How can a state be transient or
persistent if the ana group has zero namespaces or not? It is completely 
orthogonal. Any relashionship between the ana group state lifetime and
the number of namespaces that belong to the group make no sense to me at
all tbh.

> so I find it to be zero issue of having a group in change state with 0 
> namespaces as its members.

What is "zero issue"? you mean a non-issue?
The spec defines this state as a state that represents transition
between states, and hence its not surprising that the host expects it to
be as such. IMO the current host behavior is correct.

> I understand that it would be nice and dandy to change state of multiple 
> namespaces at once(if one can take time to configure such dependency 
> between them),
> but I at the moment opt for simpler but flexible solution, maybe at the 
> cost of greater number of ANA log changes in worst-case scenario.
> Thus, the cycle "namespace in state A" => "namespace in state of change" 
> => "namespace in state B" is still preserved, tho with different 
> methods(change of a group rather than a state of the group).

nvmet is actually violating the spec right now because it doesn't set
bit 6 in ctrl identify anacap, and it clearly exposes anagrpid as a
config knob, so either we need to block it, or set that bit.

In any event, you can move namespaces between ana groups as much as
you like, you don't need the change state at all, just don't use it,
especially if you keep it permanently which is not what the host nor the
spec expects.

>  > That is simply removing support for multipathing altogether.
> 
> You're not wrong on that one, tho, no offense,

None taken :)

> in certain configurations or certain initiators that's a way to go.
> Especially when it might be a matter of changing one implementation to 
> another(i.e. old good dm-multipath).

Whatever works for you...

> I mainly mentioned this because it fixes the issue on some 
> kernels(including mainline/LTS) while not on others,
> which is why I think it's important that misinterpretation of the 
> standard will be accounted for on the mainstream code
> since I can't possibly patch every single thing that lives on back-ports 
> for it(I personally look at CentOS world rn),
> while it might be the end user of my target setups.
> My territory is mainly the target and this is not the issue I can fix on 
> my side.

Again, there is no issue here that I see. The only issue I see right now
is that nvmet is allowing namespaces to change anagrpid while telling
the host that it won't change.

>  > Could be... We'll need to see patches.
> 
> On that regard, I have seen plenty of git-related mails around here,
> so would it be possible to publish patches as a few commits based on 
> mainline or infradead git repo on GitHub or something?

Not really.

> Or is it mandatory to go, no offense, the old-fashioned way of sending 
> patch files as attachments or text?

No attachments please, follow the instructions in:
Documentation/process/submitting-patches.rst

