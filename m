Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E279C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 09:36:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3781765010
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 09:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3781765010
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KQKb7s7PsUyOYu1dXY350QrSpU5Ntm474yeBkgZWJ2Y=; b=JIlz6XxlLyWj11cv4RDD+8xji
	LicnDh8sZySsnPR//aOEgTg3Tf3NQOEdj2nW9HRkpi+eya5A+53fqt06a/6gCCX4fS57kkyl6/6q5
	yHBjoaMG5JVZFKYFqffdoaswsafIM1gFTIDNSY15sDcoknHKUzMKCE7n/pHIeE0/Mwj8fZ8/vAMzP
	xWFOaCL6/gQgPpyv5gAu7WIE9eot0gJswRFRK/PwZhP3sc5I+TDdyoC77+nVszNAWGaSDwtC1Nn9I
	YnyiuGwF88FylNt7Pt7+xtWDygSEX0AulWmlSEDq5Bot2vMmGnLbXPSg71Lul0Sg4a970t6E4IP6T
	OWcrbjxeg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM67I-000Ifz-Ak; Tue, 16 Mar 2021 09:35:56 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM67D-000IfU-K5
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 09:35:53 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 16so15802899pgo.13
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 02:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sb3MvraZLSJ1eWdOAPj3FJ14ASOphG3JGUDk/GEpJms=;
 b=LVg7mwFOxzi+/7mbneNTEx8reb/bJSvCgVhecHoWRXwTw30xdbPw6Q4TpOXFmOKBDl
 9nxPqzm9ejee6vikdSjJvMAjBYbXquO4iPNYXXPTa9E6bBPzPrlcg3bjTZ9U8Y47ZcfJ
 sZb816yUmcJNnCZOLxx1lGHfy1LrAOn0zGf7kN4HckXK3D5AbyRti5N8wjyj8aqVWS7H
 NgAVb1O124d2Zy73K47BGPFDkqT0Hu1t7ajZEvbonWmNd3/x+NLZCnzCQlcG0+0GAZ7a
 UGPtwp6YH6zl5iR4B6e2t4j0aX0owuuQ1ygDnlYlkPpUl03TD65uk0CZ/DaqDCD3mFVc
 ke1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sb3MvraZLSJ1eWdOAPj3FJ14ASOphG3JGUDk/GEpJms=;
 b=o42C6thQb/LO1LDWSyXU50/i/+Vz0PpIOWRF96PVR9VMbM0ViELiCZ3XexmEFFdfII
 +FRbpusC2q9xZDQpJ4EgyLHUPQoD5ZOsZKLu1OqjGbDXFqgPLaKWurk/tf8Nac+cm+Sc
 hAAAfL5yQO/ROjcHEwBmp8SaiKnlUo6Jekl6RRsEh6NUGawr9KCoDYayjDDQDzVrgrld
 Z+F+OuhZz/9cwBnVfRCjQNLEroPwxSgmpR8Z2pGKeNEileixy6w+tGIqXxW2t8pdrCcW
 bHshljulN1TtIQuijbnGMPKftT/Zvp1XIpBJftPAjBlcBOrgu/AI7ve8n5xdB29KxBDT
 6eOg==
X-Gm-Message-State: AOAM533kACADY0yUqYquiXoxwKtldkBvNB3mJwcpiivUgJOLLld4Bj0B
 PYFVYkGy3BNTcwh73KVbwLc=
X-Google-Smtp-Source: ABdhPJxrROD6jjAWfZAbl0P2MowvXW/oHzpqi5p0bQ/GHGZtCOEKfqQZiR9BuD6xnqmJEIdqOnDIDg==
X-Received: by 2002:a65:6205:: with SMTP id d5mr3187917pgv.40.1615887350353;
 Tue, 16 Mar 2021 02:35:50 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id s200sm16101612pfs.53.2021.03.16.02.35.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Mar 2021 02:35:49 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: elad.grupi@dell.com
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: RE: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
Date: Tue, 16 Mar 2021 17:35:39 +0800
Message-Id: <20210316093539.16125-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <DM6PR19MB4011D61F1BF2A4F66228E9EEEFA50@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <DM6PR19MB4011D61F1BF2A4F66228E9EEEFA50@DM6PR19MB4011.namprd19.prod.outlook.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_093551_774900_BC7844A8 
X-CRM114-Status: GOOD (  11.07  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Elad and Sagi,

I think this bug is the same one I am trying to fix. Sorry I did not notice
Elad was trying to fix this in time.

Elad, could please take a look at this thread. I think these two bug are same.
The callback is same.

[PATCH] nvmet-tcp: finish receiving before send back response if nvmet_req_init() failed.
https://lore.kernel.org/linux-nvme/a4ae0e4b-3d59-3a5a-1533-4545e2e4633e@gmail.com/T/#t

>@@ -476,7 +477,11 @@ static struct nvmet_tcp_cmd *nvmet_tcp_fetch_cmd(struct nvmet_tcp_queue *queue)
>   	  nvmet_setup_c2h_data_pdu(queue->snd_cmd);
>-	else
>+	else if (nvmet_tcp_has_data_in(queue->snd_cmd) &&
>+			       +nvmet_tcp_has_inline_data(queue->snd_cmd)) {
>+		nvmet_tcp_queue_response(&queue->snd_cmd->req);
>+		queue->snd_cmd = NULL;
>+	} else

Here when we get a new cmd and find it has data remains to be read.
I think that in fact this request might already been replied by nvmet_req_init().
And the inline data should also be consumed by read it from the socket.


Thanks,
Hou


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
