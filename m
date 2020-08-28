Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D6FC433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 15:57:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB3992075B
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 15:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gwiD5wGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3992075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jrG2lJSv29ipNufboO7+X6ld4NvBAzA1E0WF/+8DGaI=; b=gwiD5wGdVRSLyYSMT2ECFTuB6
	K0hV0BnP+X8sJ96eekrz9bRhhKK/OBJIR/T3rgmvyyptwVfog6hfgSH+SXZeIVZxYdua/aXgiadc6
	S6PFphO7tj5shuB1I6e6J+nyDnRyrNcmU4rRwp5j/p+aAwgWgQJnAv8gKOEVpelSszt2iVRBSauvz
	gRVzXY1lMeYyW+qLtIWGXDPLIHVBw0lP6rWP/CPuPZRFrFbZgzOh7vC2W6YD6FX+sEKq6aM4QhNhe
	Wp3ZW+5qVX16Tw4e7/a+mZVjp0kSvdj+CPxFdZ3VX51A33fWL259wjPcvzp88GynA5w9nNQkg1143
	yX0TAhJHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBgkd-0007Vl-Ba; Fri, 28 Aug 2020 15:57:15 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBgka-0007VC-W3
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 15:57:13 +0000
Received: by mail-pj1-f52.google.com with SMTP id q1so708624pjd.1
 for <linux-nvme@lists.infradead.org>; Fri, 28 Aug 2020 08:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QfkAbkpz4CBuAaAbDSr9x00RvagZVBriTQKjFlHEIJs=;
 b=K9dm28Ie8/M0vCDIvp8YrNqrj8wuA80a4t0Bh4ziWuPhOQfa/AhIlfCiPtyam1SrkG
 Wvr3W+jwtjeQocG6VmOW4YjRm1oAqb8q5u9pIufLlbvAALKu+Pe4HQiomjUkiv8UMHs+
 JOMlodLaZDg8WIsZHaga1MX5XnNEZljGoqcGvWuqvI/ViZYO1AQ2uBs0sBKnW/5ahB/V
 olSqXdaQL77oFoJKIVU/PgK8KbQKp8Oo9UYWJVc3USAl6KED0Z7uz8g8Wn7kwD26qUKg
 2ofMd6QdlPvlNX7uk1W2+ppWu0ALNd2cjnQI5RKfyt16BiZpz988UzAbO/M0lzY8/5fB
 Xpfg==
X-Gm-Message-State: AOAM533MRuOWCN5S7BmQzeBqsqtRaQ0Qbdf646e2onhhJxOcEJWkFJdX
 C3UxsOyM6nKEspFfChOqH9vkNJjTsn1rhg==
X-Google-Smtp-Source: ABdhPJzuJvmvnfh8EDvJ7milMdiPTaYfot0RHrwWnRutDqkTj7G3xVpGrT2pH+DOWgV+zpyxmdhWtQ==
X-Received: by 2002:a17:90a:c906:: with SMTP id
 v6mr1860628pjt.219.1598630231621; 
 Fri, 28 Aug 2020 08:57:11 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c4b8:3871:4bc4:154f?
 ([2601:647:4802:9070:c4b8:3871:4bc4:154f])
 by smtp.gmail.com with ESMTPSA id k5sm1722443pjq.5.2020.08.28.08.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 08:57:10 -0700 (PDT)
Subject: Re: [bug report] stress reset_controller operation on NVMe/IB lead
 OOM from 5.8-rc1
To: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org
References: <769167569.38843663.1598589784057.JavaMail.zimbra@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3138aa7e-612c-8a17-4bce-dd42078892b6@grimberg.me>
Date: Fri, 28 Aug 2020 08:57:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <769167569.38843663.1598589784057.JavaMail.zimbra@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200828_115713_045983_B032D6C1 
X-CRM114-Status: GOOD (  11.42  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hello
> 
>  From 5.8-rc1 stress reset_controller operation will lead system OOM on both target/host side.
> This issue cannot be reproduced on v5.7 and still can be reproduced on v5.9-rc1, let me know if you need more info, thanks.

Does kmemleak complain during the test?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
