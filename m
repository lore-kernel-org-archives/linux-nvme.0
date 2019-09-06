Return-Path: <SRS0=wEPw=XB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C84C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:33:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B6420842
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LS6YjQB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B6420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=LS6YjQB9hscKXORN7HKfsuBiK
	x6knjxpSGH+Flqy3rVM1bpXuoVoErB4l963YWw1xVk4oxRsOG49WfaepJ4sJXTPokAoXUuADj2UOQ
	BtR4UWmEndjEQVMyrbB2fpnAkN6htfmGxJ3g9/waKU17I0NRDPmqgwi2hzWdOMzHI0hWPpAsrTdmI
	bK/3chnTQGJQAuY1nu/EeRobGMx69OFdWzFAZKy0MDtQqqzeQmAFLw+ihpHoOpip/J/DvyUAroG1q
	QZtpP8tSuqedZUW018YvUk4Fj3Tmv2GURkA25Bj8lIvhmDiN05y5gUrtOiaJ3CqEJiamF7eh3tjRr
	up8WvR6tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6Njj-0003Ng-M0; Fri, 06 Sep 2019 23:33:51 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6Njh-0003Me-8O
 for linux-nvme@lists.infradead.org; Fri, 06 Sep 2019 23:33:50 +0000
Received: by mail-ot1-f67.google.com with SMTP id y39so7340964ota.7
 for <linux-nvme@lists.infradead.org>; Fri, 06 Sep 2019 16:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=VDjA1ursmRxWG2OBDrVwxhSU1X5tStSS1sc60SyZjbYWdgot8Em2apNOfhG7Fonn7H
 556WMHOcbm68t5ydGlPvJwXx1BGvagdbc2VnTwiWovwV755YKBCfjVPThcuJVmBIY8xn
 9k5vyN9yQIlDxTnLkSD/dPegLmypdsLhWvhH1uwbDGfYfN0FJZ7LlCmnl2NSN9b4owzU
 pj3zZGVFNSZkgnBtEm0jad6kYKvGDK9tk5kqrW8Dqz2uqbrPBWUsuLA2go1AkRAcnXvf
 lT8mMspoDcUVP0B48A2WRzY3HsnpJqVBYEkZwhhVboFoyUB/obVFfXi92Hxe/cDLhwFm
 puvA==
X-Gm-Message-State: APjAAAXrHM610CpQqQ7/eD+HPXtwQe5fVq18zqxovoOLYX1HEt2CxSSX
 dnLpGBaDRiIopGZ579IIDl0=
X-Google-Smtp-Source: APXvYqzA40JNHk49fJlG4+6BN7CDISq/7dq+lZHiAe7UN6CwYTcokHmUW4SZHRC4bSdOva3rjzncKw==
X-Received: by 2002:a05:6830:1442:: with SMTP id
 w2mr10281620otp.206.1567812828369; 
 Fri, 06 Sep 2019 16:33:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id 94sm2676556oty.44.2019.09.06.16.33.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Sep 2019 16:33:47 -0700 (PDT)
Subject: Re: [PATCH v8 02/13] nvme-core: export existing ctrl and ns interfaces
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-3-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <94ec3b26-3c8d-46bb-991e-ba395dee15bf@grimberg.me>
Date: Fri, 6 Sep 2019 16:33:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-3-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190906_163349_303443_CD88B824 
X-CRM114-Status: UNSURE (   9.68  )
X-CRM114-Notice: Please train this message.
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
