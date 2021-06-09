Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02181C47095
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 09:33:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68C261285
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 09:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68C261285
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n7qdBvdEuicFIq0egnAvxU25yhZ+HTXTHnz/NNe86RI=; b=DH0E1IsdB8htF2m1q5Btajwb7X
	7XL+88tkSqOk9Br1V+FCOhSS4tuT+2KiDiD895suhSQX3VgTu01cYeO73WEwyqhSBv6K/YGzXeqP+
	t1G4S2/rNxyNRIRMVAZuqNpo6sYtrh5chkT3ViEREvzfdm5xXDBbF/hsDOEmA9gm7OdjVAvO8w/kq
	GWS34O7ZTZZE6I5BTfqHPU7v4Uf3IIInPRn+Kc6V+qFY3KcHgFzjRCpuuocQGIlo47EoHCHXUFmyf
	Z3YNAq5IzZUhDXfS3n62v9XFnWBs1Hz7aF83uQnY5iO4MeMokk3x8xa/WbBgEBJEm/6NlOSx42w4b
	T0z1nQaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqua6-00Chhq-8C; Wed, 09 Jun 2021 09:33:02 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lquF1-00CaLW-P9
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 09:11:17 +0000
Received: by mail-wr1-f46.google.com with SMTP id a20so24682770wrc.0
 for <linux-nvme@lists.infradead.org>; Wed, 09 Jun 2021 02:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FRICya+TTnBXSg5CALh3oaAVx6+fheEDDkWf3ssqE1Y=;
 b=U0Tcz3Laxhy6dMYqb49+uK3yMEMt8o4h2WwUiTzbG3p6hi4/zj4EpXTQ7td+ZLpCKC
 KpMpaE3zHvajkqbXCCCRbip7nV9fDgxNXMurpZi+oY/KkjKySv8bOzlOPvI7plaC867n
 8UaT4/fuDu4S/3GH+QvEQdXksK2I0xaD3EZ/o9xd3dIqNw0nypROyhVBFHcqC/lPFa0D
 H3ARrbw5BFD7GOldYB2U7xLXJHQ+tKKpkw56HDcKHSY29sMJTLUxgEwSgKvnkyojd6fN
 +4CDXIJP5eJa36fcXbLGCBP8ZyXVp+KhsQAYQyGwucujMyRUxpbmsgrrDCPfHSMgucxz
 7n9g==
X-Gm-Message-State: AOAM5326ZrsBR10aLCEcxk+Wv3QJxv9sy7KjT978FoPUN7slekx4O9yu
 Ynt6CL4ZOjCTv4Vh9maB+35t98sEIws=
X-Google-Smtp-Source: ABdhPJxUnGSVRqhmXODJduHg6x2ATkFd4nSuuzNbUZ+4ABj0aXAg9faGQuEItexiOmp5uP0nC8ZyJw==
X-Received: by 2002:adf:fe4a:: with SMTP id m10mr27168367wrs.332.1623229873847; 
 Wed, 09 Jun 2021 02:11:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:add4:fb94:3dc4:5c2e?
 ([2601:647:4802:9070:add4:fb94:3dc4:5c2e])
 by smtp.gmail.com with ESMTPSA id o6sm25612472wre.73.2021.06.09.02.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 02:11:13 -0700 (PDT)
Subject: Re: nvme_tcp BUG: unable to handle kernel NULL pointer dereference at
 0000000000000230
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "Anner, Ran" <Ran.Anner@dell.com>, "Grupi, Elad" <Elad.Grupi@dell.com>
References: <CO1PR19MB48850A829FEF374C7FC156EFEE3E9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <CO1PR19MB4885314DCBFEB376C7305C98EE3D9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <e40414a9-41ef-f82c-7d1c-2583d8251c26@grimberg.me>
 <CO1PR19MB48850B44ED23C179A4E4F541EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
 <b9c7e6cc-fea5-b8ce-af07-7d004116e3e3@grimberg.me>
 <CO1PR19MB48859C3254E4F3EA3282EDC9EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a76ecf8e-15d0-1ebc-aaf2-c93fee591602@grimberg.me>
Date: Wed, 9 Jun 2021 02:11:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CO1PR19MB48859C3254E4F3EA3282EDC9EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_021115_886662_0DCED31C 
X-CRM114-Status: GOOD (  10.53  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Im not sure that using the queue_lock mutex ill help
> The race in this case is between sock_release and nvme_tcp_restore_sock_calls
> sock_release is being called as part of nvme_tcp_free_queue which is destroying the mutex

Maybe I'm not understanding the issue here. What is the scenario again?
stop_queue is called (ctx1), that triggers error_recovery (ctx2) which
then calls free_queue before ctx1 gets to restore sock callbacks?

err_work will first stop the queues before freeing them, so it will
serialize behind ctx1. What am I missing?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
