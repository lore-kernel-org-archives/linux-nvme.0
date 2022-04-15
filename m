Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888DDC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 18:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h1tKDrb2kWusU2KqJ5UKYIqrT7yo83yzzjFAZ+KUf0g=; b=tch9tLgNiIeUeyoiiUMu0nhgCq
	kmz8CUCkMHsD91y8RbVY3U0YlAGc2I1yPx+tqo1BmOwck6npzQDT7/2oRW/jjHNN50J/NxPzaJ8Yd
	meEboQSfk2A3HAbdFTI2zJmSnSOLGOYLsmSfonoHM9vmLrRYYGql5s5LjNvzQ0BbYahiqLVT08v4C
	PBjCP8UCgW8hcvpTCepN2OoNX43zBVCSyYiRvIYO9wclA5dmmurHfS5sMr+0m4DL5qohQSk2Y0bU3
	Nbz7hF+pxqhGG+vtJpB2n1PuCiq9Klk8Tn0jzvqLHBvXIY+B5Bf2lyJzRl4yunvNBbuyM+infnO2s
	zbg0h+BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfQKk-00B3Fh-OT; Fri, 15 Apr 2022 18:06:14 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfQKh-00B3DJ-Uy
 for linux-nvme@lists.infradead.org; Fri, 15 Apr 2022 18:06:13 +0000
Received: by mail-pl1-f181.google.com with SMTP id c12so7661483plr.6
 for <linux-nvme@lists.infradead.org>; Fri, 15 Apr 2022 11:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=h1tKDrb2kWusU2KqJ5UKYIqrT7yo83yzzjFAZ+KUf0g=;
 b=IaG+9F9uWJwweCt05lPRJGMkadgSDy8m80q8nQf7MsR10rO21hQn9axOQvKM04lqc7
 m2A8FcOb7IBCgWyon4u5nJfcQaRos+RIwNx2E9w+oybwjuq6i7b22VljxNkaYoBTawEA
 mrKEiEVk4A5vaNZmhKDhs+XBIkfccTyuUBtN0lpZn6vDzXQdts+DCyh9EZqbmrJDY+6G
 PoBwHJaZVb5ZJ9PpIpoSxtL3qYaUeAMbrMx9/JT/WFRpIqOCaOK2VvFj0tnO4QlKkSFZ
 HDDyv293daXox9/lEl9egQa56JGquzPfpSh9MgTbyWbgyJRyLU4a8nqACXt5AIt0uA7o
 MMtQ==
X-Gm-Message-State: AOAM532fo0nwU7Lf96m7FoylMl6fIBztz/JMSEwB1lznj3OE4RDqUXp3
 zDlYRdBOElEaYUrBqBkttZo=
X-Google-Smtp-Source: ABdhPJxSElclAbIMIm0ja5zrBH3cHdG23S3Yrk4nRqbBAtH5pdZ4SAnALt4p7fBfsb5FVmhlcrmtAw==
X-Received: by 2002:a17:90b:1886:b0:1cb:8e79:8ebb with SMTP id
 mn6-20020a17090b188600b001cb8e798ebbmr99186pjb.176.1650045969837; 
 Fri, 15 Apr 2022 11:06:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a014:c21c:c3f8:d62?
 ([2620:15c:211:201:a014:c21c:c3f8:d62])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a63a442000000b0039cc5a6af1csm4926454pgp.30.2022.04.15.11.06.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Apr 2022 11:06:09 -0700 (PDT)
Message-ID: <4c2f1a15-8d65-b234-a99f-354b4cbeef54@acm.org>
Date: Fri, 15 Apr 2022 11:06:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: can't run nvme-mp blktests
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org> <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
 <YlkAlHe6LloUAzzN@infradead.org>
 <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220415_110612_041321_8536DCFB 
X-CRM114-Status: UNSURE (   8.69  )
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

On 4/14/22 22:58, Chaitanya Kulkarni wrote:
> If it doesn't add a new test coverage in the blktest framework
> then please remove.

cd blktests && git grep -nH dev/nvme-fabrics
tests/nvmeof-mp/rc:94:	[ -c /dev/nvme-fabrics ] &&
tests/nvmeof-mp/rc:101:					echo -n "$loginparams" > /dev/nvme-fabrics
tests/nvmeof-mp/rc:161:	if [ ! -c /dev/nvme-fabrics ]; then
tests/nvmeof-mp/rc:162:		echo "Error:  /dev/nvme-fabrics not available"

Does this mean that there are no other tests in the blktests framework that
test NVMeOF and hence that it is useful to keep these tests?

Thanks,

Bart.

