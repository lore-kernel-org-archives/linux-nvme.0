Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224DEC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 19:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aAEj2z5j4rN4w6X3AYcfh5DYvWwVn2tCNouMHhk/4Hg=; b=pwJH4fip4lm5QqSMPwIYwTVHHM
	EzBZjexmEj7cz4j3chVWaxh6A1QuG3qH7/2W+s6ueAJD8TWKrm7+snhsgCTV0BNaO4dTPPk8fQWPw
	lWcE+1aOrfll6L/rkYfs0cD3gCp2AhSV9eJZ9+m8zWfBqWILb/g7LdSnoTo5ADfcn4M/UtyrcrMHI
	/bdXIPgY+lpqyHMBcvHeMZUMlAT6P2K4X+Ya8GLYKnfym/XX7fl6tIlhW5oVyoF5p4X7Nhcgp1NMq
	0BZksNmHhPMOvQBh9j++5dIPjCKahccuDyqK3teHppCeEwx1iXf3rDgb4O/mAYCsw01C93PXncjYe
	jAu21yKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCRLW-009w5J-O5; Fri, 15 Jul 2022 19:51:30 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCRLT-009w2T-Cq
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 19:51:28 +0000
Received: by mail-pl1-x62a.google.com with SMTP id q5so4032278plr.11
        for <linux-nvme@lists.infradead.org>; Fri, 15 Jul 2022 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aAEj2z5j4rN4w6X3AYcfh5DYvWwVn2tCNouMHhk/4Hg=;
        b=x5GtODR6djC4ltsn1mXT07cTWndraIHznXkvheaFSux28/X1CrrD5aDWmL/AwHY879
         zIhGL2Q1cSRZCFw1MYESrc1KeGsEvO3nBsgFt5GCmYZOFPNasUc/56QpqbScTlAXbr0Z
         FMivWGhV6ZMNRHxZ+sTbfl1kdq8bftf47HNlpfxjrGuaX65IX38edlu+tnGK7SX/4yN8
         swDN1TZy7Cqr5BmXNW4rmkDwgPsMGh1YSP2dMIS7RYjn/RE4G7Zo3UaPJ6FIobqhBMKo
         8anOQjBlhaw/a9RMYGQiGrhZ/2pOyDdccF1p1KuEAZb2L0y4I/13+MQsw63q/kwJYAaE
         kWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aAEj2z5j4rN4w6X3AYcfh5DYvWwVn2tCNouMHhk/4Hg=;
        b=Qnd4i42PkVTu++lg/7fxaS+YDUFIMjx4C3iRyHwImkt/xUd1/2AGEvWFVoxd1Ay1dH
         hb6lbvw43gRQh0/LvfUL0FtlDP1+qo77znw/vl5ysfQD1bNqMVtk46JRvfWvuUwM7iOi
         xD1Xps2IzuELMnLFRs3S8m32sTLrWIb9zzQXMzP+0hV/6YTsUTn93DWJ+9LZjt62XHSO
         R5NIRPAiBP0vfWALCCMZleKogEjjLBQz8gf6P/Oz4dwzd0Sr4fuGaSfbtM/cgClVUJQc
         ZRu3Y2xV9JMYlSK1rqb9IPfziGILBTaaGBVuJcQ+lOsOtY3S9o3NoQ60D30ppteMiN3A
         gZmg==
X-Gm-Message-State: AJIora+C8h/OIxZ3ZtaSGXY6YvpnYHQtq3CmSZvf75DvQH2SubnORXBL
	ZXozDkXXswNYyve1TVNrUWt/qg==
X-Google-Smtp-Source: AGRyM1u5R2xGXHm/wIzhsGKVgEdopo4Wk8YMYiEujVEhjpeUiDwtfTDu0FzwJ7TVLEhVC+DpZbH40Q==
X-Received: by 2002:a17:902:c102:b0:16c:acf1:60e7 with SMTP id 2-20020a170902c10200b0016cacf160e7mr10273131pli.93.1657914686557;
        Fri, 15 Jul 2022 12:51:26 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c6-20020a63d146000000b0040d75537824sm3565275pgj.86.2022.07.15.12.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 12:51:26 -0700 (PDT)
Message-ID: <7e2c6bc4-8aef-3334-fbbf-d67e7de617fe@kernel.dk>
Date: Fri, 15 Jul 2022 13:51:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] nvme: Use command_id instead of req->tag in
 trace_nvme_complete_rq()
Content-Language: en-US
To: Bean Huo <beanhuo@iokpp.de>, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, beanhuo@micron.com
References: <20220715194804.324158-1-beanhuo@iokpp.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220715194804.324158-1-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_125127_458484_3EAE6A04 
X-CRM114-Status: GOOD (  10.28  )
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

On 7/15/22 1:48 PM, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> use command_id instead of req->tag in trace_nvme_complete_rq(),
> because of commit e7006de6c238 ("nvme: code command_id with a genctr
> for use authentication after release"), cmd->common.command_id is set to
> ((genctl & 0xf)< 12 | req->tag), no longer req->tag, which makes cid in
> trace_nvme_complete_rq and trace_nvme_setup_cmd are not the same.

Needs a fixes tag.

-- 
Jens Axboe


