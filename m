Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E312C3DA79
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 08:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=af0c4qw0ceHWmNUQwBLGyaQWzbBLs0yH9j68AMi/ymM=; b=RM1yrwhv+8QDTMjC9JUkYLz2KF
	NtLIQl2nqqArRwAgKgnHy6Uf6QN/48GSoxS1Hi7aKDqO0xxIobML6bv5xZKApjVvSWHNEf34+TQR4
	OY/VOQIr2trg4B/jTILqFVCjk18kgOu2fpwNTGUO94WFEDp1lP8onDnX8Lpsle1nplxQUU8+nOXBE
	n3Li79/R2V+Ywmg/5+F5XhMtLzjX/nqIEYfSW8YKLSfArGpHARQJJcJ8zRe/gdccn2yHaZXUfQkEo
	fXZOLcq4SVI5P5DREq1G0w2dSUTaKq0in6wso1eKqgoabb5m9s9tmMbvVqus6MYBNizIOmgdx/4km
	Rvb9Q+Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPIcV-008IgO-2o;
	Mon, 15 Jan 2024 08:46:59 +0000
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPIcS-008IdW-1M
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 08:46:57 +0000
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ccec119587so102838051fa.0
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jan 2024 00:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1705308412; x=1705913212; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=af0c4qw0ceHWmNUQwBLGyaQWzbBLs0yH9j68AMi/ymM=;
        b=UlP3oELfFLOtOdJKudz1cyoprz3DxyvFroAEIaYHZ7Zm5SVUmoUgizM97OZAYn7tOu
         NMItwqy37uB1/fb3J6FWr8VBvDHfF7D7vDZJSX9UbUj715zLZa3swag8Kn/+Js6S7zFx
         KyTawJjuc2vUS5NGPTJg1SECUqMwA/O9y0uCLfYiCj2qGwZkq6sj4XvgSdPVPNlcq4GE
         aM7Kyh7a2+2c9nSkDkB7IcGIMin9KhOG8rhaYOvfqtzPLdcEHLmhgDz6V4//zS1NEcxb
         URGjM3Fpygf3Bhq7SSU37uAah058Cpj5MIkRe+ekZkN2oq3CXM3oLf/yLazCwSBfCt/d
         UWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705308412; x=1705913212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=af0c4qw0ceHWmNUQwBLGyaQWzbBLs0yH9j68AMi/ymM=;
        b=vrp5buQ4g07tT4pcv0NZtmmy2hPR1fiqTe7RysbxHonnqImQnSOPsgdvRvhWPQzQQA
         NDCu1JHreisM4lgvfHcFjACccq/KkxYhsB53qaHQGOsl6p6Kkqv/0p7ZFGYWd5tNQiy2
         W2BxDsqfAJaqNyUyYWDIlZAdQkSmtakwY93gvaCBzoXvLMD8GG9YuWic/bqKlyaG4Vd+
         Ve+KO9lRVK9NtROd9W5onl2/x9+WopeboWvXE4kEy1imHjmteGXvrKV7tCOL9+53qYLe
         ZYle2XscSxE3Y5sluGTXYIFlSBqZEOaPONQq3zHdazUMpLumQfZw2xKUS87hir2pyWwW
         Anuw==
X-Gm-Message-State: AOJu0YzH1ffmkgWnTdE+6+/I5G0DuJf8KCltsyvCnyHr7/eDFbk0GgpN
	fJGxMD328StgExl+eGOB2yiNJ1Zowi+d7g==
X-Google-Smtp-Source: AGHT+IGK8MH+CazDutDh5KhUA91iPm2QS3HgOT+gj3DZbv72Ccmc46G2CeN6HPpan13U+rWLqo9+kg==
X-Received: by 2002:a05:6512:234e:b0:50e:6457:2bc2 with SMTP id p14-20020a056512234e00b0050e64572bc2mr3307332lfu.71.1705308411949;
        Mon, 15 Jan 2024 00:46:51 -0800 (PST)
Received: from system76-pc.. ([2a00:1370:81a4:169c:b283:d681:9baf:afcf])
        by smtp.gmail.com with ESMTPSA id y22-20020a056512335600b0050eea9541casm970160lfd.44.2024.01.15.00.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 00:46:51 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	javier.gonz@samsung.com
Cc: a.manzanares@samsung.com,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	slava@dubeiko.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability for kernel space file systems
Date: Mon, 15 Jan 2024 11:46:31 +0300
Message-Id: <20240115084631.152835-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_004656_463142_412C8B28 
X-CRM114-Status: UNSURE (   7.30  )
X-CRM114-Notice: Please train this message.
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

Hi Javier,

Samsung introduced Flexible Data Placement (FDP) technology
pretty recently. As far as I know, currently, this technology
is available for user-space solutions only. I assume it will be
good to have discussion how kernel-space file systems could
work with SSDs that support FDP technology by employing
FDP benefits.

How soon FDP API will be available for kernel-space file systems?
How kernel-space file systems can adopt FDP technology?
How FDP technology can improve efficiency and reliability of
kernel-space file system?
Which new challenges FDP technology introduces for kernel-space
file systems?

Could we have such discussion leading from Samsung side?

Thanks,
Slava

