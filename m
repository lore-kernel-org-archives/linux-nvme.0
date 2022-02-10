Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C64CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 22:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dqHpYTRHZGMah/N5IZbiKNt6sU5W73cjUR2JOzJZ12I=; b=S6LAF9ABW7S8vPYGs+skBxowri
	yvaUxnBrQHbIeGUQznZgSWKmwDnM3uTpHHlQ48YshKL2QLP/kLnr4iY0HzL2PCh5KkBtbvj6orS0k
	tA4SnZKaO+O/5Y3w+TnwTkrVHZnUUL5sOGgsi8vF0ytBPdTYDARx64LaLjgRcQzSZ3rPGUwp4XV4g
	ODd53Vs1o9etpzoicPOGknV6GkQLGJjIBcaLyHWopyBXrwhfktp6lfD48Ii+KAtuCLtZN/dF9U1Hz
	u6tDlr3fVcpGFs3+WSL/JJ/gMjZl/dMus1pbqYvySJJeRAC0D//yaBVKXBuuoEYwjsxituf9d+PU7
	WqQvknWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIHro-0051zw-GX; Thu, 10 Feb 2022 22:24:44 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIHrl-0051zb-9W
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 22:24:42 +0000
Received: by mail-ed1-f44.google.com with SMTP id y17so11493353edd.10
 for <linux-nvme@lists.infradead.org>; Thu, 10 Feb 2022 14:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=dqHpYTRHZGMah/N5IZbiKNt6sU5W73cjUR2JOzJZ12I=;
 b=E5qbrI1YTmHf0jG6995aV6JShWk35z0wuLjDj8CB/uy/h5YjHmyL/p3sDCQio6h8jf
 nchqUohpREQypy7W4x45N11/kI62RXIr3D1bGmNCnK1CBSPIem9vIhPoaW0Hafn6e3Jx
 FjgW/Y0RsKr01UfzRjgRIlo7kXN8YdD4OW/vQPVKDZNncqkn0NkNFL+V2MaqF449zqE6
 G2Vzr87UwzMYnQCwwXuVRhF9BlDUVrh7AZvC4t3o2oLpozRc62xz4hK3y9DQlfq5C42B
 +/geTbMPMKqnMBMnt5VXkvojc0ycoS1Ygz4X94ETJ74pfbl1TJ1xF8nOIWOUV7vqcn8A
 7J2g==
X-Gm-Message-State: AOAM530+RiKyCcMcvjVloAmkEP5UuNdJcE7IVzY8v5KH3SHG01KhUhkv
 +SHhvadjunO4j8HTSayTpyg=
X-Google-Smtp-Source: ABdhPJwP2JIUaDxOduTd7f2mC9hoR2s5lsVcwxk0fjCrAGyybhMCj8f/tKrdJ/gvFyF1rhy+Jp4qtA==
X-Received: by 2002:a05:6402:d0d:: with SMTP id
 eb13mr10416413edb.83.1644531879028; 
 Thu, 10 Feb 2022 14:24:39 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id n24sm4357535ejb.23.2022.02.10.14.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Feb 2022 14:24:38 -0800 (PST)
Message-ID: <fd8600bd-aa73-82f7-3ca7-ed7f766f1568@grimberg.me>
Date: Fri, 11 Feb 2022 00:24:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: NVMe over Fabrics host: behavior on presence of ANA Group in
 "change" state
Content-Language: en-US
To: Alex Talker <alextalker@yandex.ru>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 "Knight, Frederick" <Frederick.Knight@netapp.com>
References: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
 <9a765265-0200-0eea-872f-780c4dbb69b8@grimberg.me>
 <02375891-2f92-c3d9-8a55-019b84c14c1c@yandex.ru>
 <205b91c3-4da1-744d-3d06-ccfdf2b93cff@grimberg.me>
 <5b5cfff7-6c07-0cb1-491a-0fa3d13c2cbd@yandex.ru>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <5b5cfff7-6c07-0cb1-491a-0fa3d13c2cbd@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_142441_387469_E9AE3A5F 
X-CRM114-Status: GOOD (  18.07  )
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


>  > Can you please stop top-posting, its difficult to follow this
>  > copy-pasting-top-posting chain that you are generating..
> 
> My bad, I just had a hard time taming my mail client in all this 
> plain-text mode requirements.
> Also, I was a bit confused on how to handle branching-off replies :)
> 
> 
> In short, my opinion, after consulting with NVMe base specification 2.0b 
> stating is that:
> 
> a) (8.1.2, page 340) "Namespaces that are members of the same ANA Group 
> perform identical asymmetric namespace accessstate transitions.
> The ANA Group maintains the same asymmetric namespace access state for 
> allnamespaces that are members of thatANA Group
> [...]The method for assigning namespacesto ANA Groups is outside the 
> scope ofthisspecification."
> b) (8.1.2, page 340) "An ANA Group may contain zero or more 
> namespaces[...]The mapping of namespaces,[...] to ANA Groups is vendor
> specific."
> c) (Figure 280, page 270) "ANAGRPID[...]
> If the value in this field changes and Asymmetric Namespace Access 
> ChangeNotices are supported and enabled,
> then the controller shall issue an AsymmetricNamespace Access Change 
> Notice."
> d) (8.1.3.5, page 343) "While ANA Change state is reported by a 
> controller for the namespace, the host should:[...part about ANATT...]"
> 
> Thus I see it that ANATT-based timer should be started only upon 
> condition that a namespace belongs to a group in this state
> but change of relation between a namespace and it's ANA state can occur 
> either because ANA Group state has changes(and this would affect all of 
> the group members)
> or when ANAGRPID is changed(and this, if the new group's ANA state 
> differs from the old one, affects only one namespace at a time).
>  From that, I find it is logical to no-op on the empty ANA Groups in 
> "change" state since I don't see the standard explicitly disallowing 
> that behavior in any way whatsoever.

Sorry, at least I and the original implementer (Christoph) disagree with
your interpretation. Not to say that we are both wrong.

Adding Fred for some more clarity here.


