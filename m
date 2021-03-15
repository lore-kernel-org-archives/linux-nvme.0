Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA67C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:30:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2135864E98
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2135864E98
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VFTae83vLYHbanwfhaaYx//dRXG7sHYH93qMuJMv9v4=; b=LCOa8MjVUE0RDfg3ioBuDPYfr
	F2ccF1OwepHOar5riU3+lG14SXd7WCRA2Yp7RlXyPzFt3Ac8PtXl8NMkjnLx1WrEqcRvBgD2XnlYD
	fdalgGEBM1jd/UAWTZIczJiDTz7jMzpntlmI11QtnLimWDgaW/PYrfxT+0Q31Iafzrl3A4TbnRNYe
	CUlqWZGH/txKO7XwuTgjZxzZ/tJlkVichv+LF05sJrSy3yUU8HncyTUyDG+aSNyMApMLOwaJS/Snd
	J8ZntdkpJDQoVU9CEAJh5sFEFby3LfpA87fIwQHGZZbqRqhJs8uLkb1dgNfOrn1vfadrXPWiMXt34
	XTTQheQpA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLr2M-00GW5u-HF; Mon, 15 Mar 2021 17:29:51 +0000
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLr2D-00GW4L-AH
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:29:47 +0000
Received: by mail-pf1-f178.google.com with SMTP id y13so7051886pfr.0
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 10:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3DSyHgBqK0yCPxe3FWhkCRQL+FeWMR2EQ7BbqzkYJJQ=;
 b=kk7lL3dAN3uF3Xxiww4QfFkV2SXAbJzN19h+TN/Rd097bf64/gVdZDXiMhVXeePXRU
 AMXOXJwM6inOQiLabKh5h9Reyx6H2VC4xN7cx0+87loBZIVuCYgrnDUaztjC8on3a3/B
 PE85gDIsumvCGiGLfCuGo17rekayJjMM/ihDbxO0f0XSsYBswVH5uVMbrD42SCASGMTz
 OdfhOnoVZ+Hzx8wFd3/UBVnztqWUFh2yS2lh4j323GPpLRZBLZJTTP1w4S/LpVyWo6Sz
 WTNDKVZOx8ltqnVxYVo2s++4i+PXfOnQIVcLm2dF6ws89mwNGOnVz4+6anKN1gZsejZa
 5/aw==
X-Gm-Message-State: AOAM530wfhi10+JTgBELG3zjbTPWw9FRlJdPsqCQ9dhCiZsSzL6dMyiq
 /z0azzvHGkM344TFFRPcnnVvISqO7QQ=
X-Google-Smtp-Source: ABdhPJyDsQDP3VrAVjPpbDVFc/vCbX4FgMjkzP8+zJnmI5rNRkoQubqvzdqV4M7trPEPEJ/wF9rcLQ==
X-Received: by 2002:aa7:8d84:0:b029:1f8:3449:1bc6 with SMTP id
 i4-20020aa78d840000b02901f834491bc6mr11056221pfr.76.1615829379409; 
 Mon, 15 Mar 2021 10:29:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id h186sm14202892pgc.38.2021.03.15.10.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 10:29:38 -0700 (PDT)
Subject: Re: BUG: using __this_cpu_read() in preemptible code observed with
 blktests nvme-tcp on rt kernel
To: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org
References: <2052426528.19238323.1615703548200.JavaMail.zimbra@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <99ff5e9a-1ff5-81f2-0ef0-68461ddbf711@grimberg.me>
Date: Mon, 15 Mar 2021 10:29:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <2052426528.19238323.1615703548200.JavaMail.zimbra@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_172945_630124_0EB7FE76 
X-CRM114-Status: GOOD (  13.26  )
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


> Hi
> 
> I reproduced this issue on latest rt kernel, could you help check it, thanks.
> 
> [   76.812567] run blktests nvme/003 at 2021-03-14 07:29:39
> [   76.880530] loop: module loaded
> [   76.893827] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [   76.895766] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [   76.898923] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:f1d7a9f1-79ef-42a3-952b-59c7338f3b54.
> [   76.899061] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420
> [   76.899063] BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/u64:25/231
> [   76.899065] caller is nvme_tcp_submit_async_event+0x128/0x170 [nvme_tcp]
> [   76.899069] CPU: 3 PID: 231 Comm: kworker/u64:25 Tainted: G S        I       5.12.0-rc2-rt1 #4
> [   76.899071] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.10.0 11/12/2020
> [   76.899072] Workqueue: nvme-wq nvme_async_event_work [nvme_core]
> [   76.899081] Call Trace:
> [   76.899083]  dump_stack+0x64/0x7c
> [   76.899086]  check_preemption_disabled+0xb6/0xd0
> [   76.899090]  nvme_tcp_submit_async_event+0x128/0x170 [nvme_tcp]
> [   76.899093]  nvme_async_event_work+0x5d/0xc0 [nvme_core]
> [   76.899098]  process_one_work+0x1c8/0x3f0
> [   76.899101]  ? process_one_work+0x3f0/0x3f0
> [   76.899102]  worker_thread+0x30/0x370
> [   76.899104]  ? process_one_work+0x3f0/0x3f0
> [   76.899105]  kthread+0x183/0x1a0
> [   76.899108]  ? kthread_park+0x80/0x80
> [   76.899110]  ret_from_fork+0x1f/0x30
> [   86.912113] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"

Annoying... why can't we just get an advisory hint of the running cpu
without disabling preemption ?!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
