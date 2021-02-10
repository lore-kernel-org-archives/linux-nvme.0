Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D30C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 22:06:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA2064DBA
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 22:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA2064DBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zmMJLG0G/jziAamqq9Gs0joHicBb6Kbj0W6009T8FAg=; b=AYYNdJaUbifXSEfIgDXMJ1QAN
	Ou/eib3ByLrxlzC6YyD7EdIxesh8JOZVXSUyo9DTJmT4GrDQzqzGaH+XUUvSjvIx+RnJiEkhuq4tp
	8EziKEh64eOAqjhwTdXwF+ENmfV26b2N50vsMtZzC83vZfbnGoJ4ck/59zEk18BOnaLddWxEfs9rh
	pXbHRlrZginQQ6v4hd4sEWHR+dyCi6lv/N1DhevVSPquYmQ26XJTiJFkXyCW1dsW4MR934t8lhcMU
	YcRRUBZnkPmoJbaX8JLmcgXhIDpnzZNA38K+6zuT6GzsrR8epGLbxMDHdYrkS08zQdOwW0Nyct99F
	suY4qifjA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9xd7-0002GT-U4; Wed, 10 Feb 2021 22:06:37 +0000
Received: from mail-pl1-f176.google.com ([209.85.214.176])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9xd5-0002Fy-93
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 22:06:36 +0000
Received: by mail-pl1-f176.google.com with SMTP id 8so1984679plc.10
 for <linux-nvme@lists.infradead.org>; Wed, 10 Feb 2021 14:06:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9/1yz6Sj+nYzo9QwRx9drCzv7Ae9nz8CKKb4s5zl1oY=;
 b=Zzivy5A4qTZZnoHd2OhuMrXljpPRu6MZ4v3W5rQ2rSX76JdsqSkeDYn1vzQwTUBoFI
 bL5HguplBBAG3ggofyqCcoePVYb8Y9USGPN65AP7D2BglyIvt8FIj/Doxha3AcK3cW5k
 SQuXI0bITfoyPhKm11T7We6loIhNAtiG5POUmCPlLikYIgMHFyuOvvqfGMe/5I5v/ZWf
 dO9m0OqPBQzPv+b/35IyVQDl6vjgFCZR904Gtdb3DYCr7vYnBendG/DL/uwp58RHgN8g
 7sFh5G1ODdCs7OzbpleSWlzxCvIvq/LN/CuIc7BvvgEM8akOhFbJ+pyRFfXLiXJFOKIw
 iNeA==
X-Gm-Message-State: AOAM532VtMrestUARph1qQuihA1Q/C6yJq3Z1WD3rEbsLALjidMs9vjn
 jjH6DDclTx3f0cgQMSh7JjQ2cf+YCt4=
X-Google-Smtp-Source: ABdhPJzDqxibWtlOB1Zf6iGCyu2PvpDL8llJIbwLF1crP/c64SHaCgt4cMW01Ev5LGy2lrup5OrqAg==
X-Received: by 2002:a17:90a:4548:: with SMTP id
 r8mr1031910pjm.16.1612994793688; 
 Wed, 10 Feb 2021 14:06:33 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:d52b:e830:d3b2:ec6f?
 ([2601:647:4802:9070:d52b:e830:d3b2:ec6f])
 by smtp.gmail.com with ESMTPSA id h10sm1287682pfq.97.2021.02.10.14.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Feb 2021 14:06:32 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Yi Zhang <yi.zhang@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
 <aec13f12-640c-77d5-bbdd-b4a3e18f1bf2@redhat.com>
 <6ae16841-5f51-617a-aab7-666b7eed299c@grimberg.me>
 <1a520912-ac7c-1a3c-c432-b382a5da6177@redhat.com>
 <BYAPR04MB49652279710E99EBB6F8AC67868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <502e8d85-90cf-9533-0f83-364bee2fd34b@grimberg.me>
Date: Wed, 10 Feb 2021 14:06:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49652279710E99EBB6F8AC67868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_170635_362902_8DA5E6F4 
X-CRM114-Status: GOOD (  13.72  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Rachel Sibley <rasibley@redhat.com>,
 CKI Project <cki-project@redhat.com>, Ming Lei <ming.lei@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> So it's nvme_admin_abort_cmd here
>>
>> [   74.017450] run blktests nvme/012 at 2021-02-09 21:41:55
>> [   74.111311] loop: module loaded
>> [   74.125717] loop0: detected capacity change from 2097152 to 0
>> [   74.141026] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>> [   74.149395] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>> [   74.158298] nvmet: creating controller 1 for subsystem
>> blktests-subsystem-1 for NQN
>> nqn.2014-08.org.nvmexpress:uuid:41131d88-02ca-4ccc-87b3-6ca3f28b13a4.
>> [   74.158742] nvme nvme0: creating 48 I/O queues.
>> [   74.163391] nvme nvme0: mapped 48/0/0 default/read/poll queues.
>> [   74.184623] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
>> 127.0.0.1:4420
>> [   75.235059] nvme_tcp: rq 38 opcode 8
>> [   75.238653] blk_update_request: I/O error, dev nvme0c0n1, sector
>> 1048624 op 0x9:(WRITE_ZEROES) flags 0x2800800 phys_seg 0 prio class 0
>> [   75.380179] XFS (nvme0n1): Mounting V5 Filesystem
>> [   75.387457] XFS (nvme0n1): Ending clean mount
>> [   75.388555] xfs filesystem being mounted at /mnt/blktests supports
>> timestamps until 2038 (0x7fffffff)
>> [   91.035659] XFS (nvme0n1): Unmounting Filesystem
>> [   91.043334] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> 
> But write-zeores is also data less command and should not fail.

And it has a bio, which means that nvme-tcp tries to init an iter
for it when it shouldn't. So the actual offending commit is:
cb9b870fba3e, which cleaned up how the iter is initialized but 
introduced this issue.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
