Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363AFC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 09:08:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6AF361998
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 09:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AF361998
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0ZjU8CJdyri8mwvVY/rJZeWZ6SxMtEF19rnbvkiiqgs=; b=FSE5qI+blYfsGzF+9q9SpgQ11
	n5jKMjDWeqDmsezjZMa/jgzT1h/AL/0ukqlMhK5agB2re0IdjUmMgFfeUb+AbzBdiJzeld7glYBv2
	1Vkxb6fC9QNAac79Wg9wZx4eRoytCE8+UYCS7be02Bl/5PtkrnhCxOYUj2j9FbEhv8EXRwFbn0z3T
	ucEH/n6JULEnd8oL0UsRTLGuxgT+RsbvtL9tx7Cx2sJoIYsneQNQOprZ7g522T7mA/gzt3Ee9VM18
	7dre+qj3zVYeEdwByWDE7tTE1qSelEXNrC9WXDKXwhw30X7xAS/jDSlmGgV93GazELcFRCblv0ICZ
	ynEHDFfmQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRWpR-0063zS-7i; Wed, 31 Mar 2021 09:07:57 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRWpL-0063xr-Uz
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 09:07:55 +0000
Received: by mail-pj1-x102f.google.com with SMTP id s21so9181520pjq.1
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 02:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pLHyN16b7LS4IamsbJogyBqxyFSin/swawMFUHkPZgs=;
 b=IB1GSjtgz8HNxOCYxpW247qu05Y9srCY+f7CyK70uwtCnixS+nfx+3BhizQRIcxoYK
 fsKRFze508xMBx+z4Y1wGrlx78mnUjSjHH4OexPwt471lRpY8jWHlJ3gfco8F98Qwi0r
 GAcrkvktU37LK+YWOv4g9va0rHBK2W4NN+dZJr2HXtuvvQEEmrB4ZdRvW/VNmLqk40US
 hxbIOfvMyUZxLBHgJ09nAi2Y/kUH7++3cOQasmGMYyO/LEIQVWImMhFVawX1KLJNgSGI
 K02nGu07dlmRx2HgUqij3LSJj5xjPRUb5F4tlAsO09FebWOrZwL0y2da++2xLM44Dk1G
 0kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pLHyN16b7LS4IamsbJogyBqxyFSin/swawMFUHkPZgs=;
 b=jORJMV8AnxaIuZZV1LaTlPpJORATfxEb9mpbod15jHvn2PDBwjb0p0EoKfC5d1AAE7
 ulV3TGJcrvDXydpFaLeLjP5wDZoKaLVaiBdcPI43R7soERqwjVuY2Hiv4gGHpfze3AEZ
 15WZIFPp//ONJt8PucEix9GFVbH7wUQ0h3DlmGT41QXZYX91+I86ife/INAmRNDmxBz6
 ptRqW/ktZnSQJt41KIfVWQieD0bcjfXyW34tdQP9Jp7YVbG81biLDbuX2me0Z82Nq+Tw
 JqgsK6oFjmgSI0Om7i7J8lclHJr5bb9+JJpXXz5Rd5NibZcM7UXh9jeEoCMGnj12ICGh
 vjGg==
X-Gm-Message-State: AOAM533k9vJGoHqrn83FMgj8uOUZbh+unRMfCdIdfz88jFoK1iN7wm1x
 qs/ti+a958x3+FTmwOJZ94XOlTqov3u1YRo5
X-Google-Smtp-Source: ABdhPJzlNwImckrCMN3BlrevjQrX4nOyHNExDQ89z4X5l7i+j2T2K4VH7A8YaM5kd5nXr5JHX1dwqQ==
X-Received: by 2002:a17:902:9a0c:b029:e5:fedb:92c6 with SMTP id
 v12-20020a1709029a0cb02900e5fedb92c6mr2324380plp.59.1617181670560; 
 Wed, 31 Mar 2021 02:07:50 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id g15sm1721589pfk.36.2021.03.31.02.07.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Mar 2021 02:07:49 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: elad.grupi@dell.com
Cc: houpu.main@gmail.com,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH v4] nvmet-tcp: fix a segmentation fault during io parsing
 error
Date: Wed, 31 Mar 2021 17:07:38 +0800
Message-Id: <20210331090738.48806-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <DM6PR19MB40115FE64DF309D2591B9879EF7C9@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <DM6PR19MB40115FE64DF309D2591B9879EF7C9@DM6PR19MB4011.namprd19.prod.outlook.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_100753_430811_8690C8D9 
X-CRM114-Status: GOOD (  10.75  )
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

On Wed, 31 Mar 2021 08:28:46 +0000, Elad wrote:
> Not sure I'm following.
>
> Once req_init is failed, nvmet_tcp_handle_req_failure is called and changes the state to NVMET_TCP_RECV_DATA.
> In state NVMET_TCP_RECV_DATA we should not queue the response before it is get off from the list.
>
> Am I missing something here?

1. nvmet_tcp_handle_req_failure is called, 
2. Return 0 from nvmet_tcp_done_recv_pdu
3. nvmet_tcp_try_recv_data() from nvmet_tcp_try_recv_one(), After finish
   consume inline data, nvmet_tcp_execute_request() is called. Here
   NVMET_TCP_SEND_POSTPONED is not set. As nvmet_try_send_data_pdu()
   is not called yet. (it will be called after we return from
   nvmet_tcp_try_recv_one()).

Thanks,
Hou

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
