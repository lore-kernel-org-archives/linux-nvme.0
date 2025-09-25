Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710C3CAC5A5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K+YFgHQ4Teu+XFPGZnoAo5eSaI9P010gBxD5eRvHMl0=; b=jzHDJSlUhvkPMiIbRKDdaSJS9H
	oqvAeXAWFy/EF3DMY4Y9dDEjTm2rUej2melu16Md9xyZG3V80Bvqy1poZPMQh0gX/XIxt2CEstH7k
	qBqU56L608RkMX7+bQ4J3sGFbSbfT54nRoiA2mwLNj2W+9t53p1aDAJrzsMbCuVBgriEFeJFDEhri
	eqURhx8GflNxeDDIghJvRx5sCBIWtaRrSpP9Xu67KsvGasZhKNcHitc8FznUZCNcSs0qxeqRogAtA
	JBy09+Yg2LG1GsCU7xCO0LcOz7xm4dFPdsr6msoKSfh1vWAqpB/H3ysdPYuZ4emYgkaTTI8XMSH9s
	k8mh7yLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1mDC-00000009WFf-1dKP;
	Thu, 25 Sep 2025 13:40:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1mDA-00000009WEg-2HPg
	for linux-nvme@bombadil.infradead.org;
	Thu, 25 Sep 2025 13:40:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=K+YFgHQ4Teu+XFPGZnoAo5eSaI9P010gBxD5eRvHMl0=; b=YH5wX8OVV2NmVftgf5HpYZMnuj
	X+DpRoGnQ+dcipjqZWrFhj2w0lSLRyg8Np+Lfc9JMLt+WRY3v/H6DP6+cS/S5ItDqrD6flW5jJ8bR
	rdX2wu5Tk9yhNNLfshBvLH8z99sMVj2lnwpfniSnPP4HuKKS9owASOg7Q9qyiPrOcJLwlXrfmIVyC
	iwdGiDUmtUstaBYAK93RKxqj2OzgjSq8Q7J5tp73hYwMJn87YSzdEgEBTaT0cxrJ5emmJdvtbv52X
	YcVD+rUxWRc06oRDS7IQsPcZRfwYghlqioIyfIp92Iyml4TzBECvWeFZKhyhiSosJx7KL4DoPovjD
	RsivHdfw==;
Received: from omta040.useast.a.cloudfilter.net ([44.202.169.39])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1mD6-00000009A41-2o4b
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 13:40:39 +0000
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id 1k2tvtYFBv7241mBQvsfvh; Thu, 25 Sep 2025 13:38:52 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1mBOvAwgQBc9y1mBPvw4c8; Thu, 25 Sep 2025 13:38:51 +0000
X-Authority-Analysis: v=2.4 cv=ZcMdNtVA c=1 sm=1 tr=0 ts=68d545eb
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=TDP2S4RWD7HzL5QBIXWMeQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=EiXV_-hVxRXBCySLXD0A:9 a=QEXdDO2ut3YA:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K+YFgHQ4Teu+XFPGZnoAo5eSaI9P010gBxD5eRvHMl0=; b=zE6RtRIDyskQpB2rC8J2HUJRt3
	0rf5pvzUTlL/0cddhj0NBkyikRRNVt2mWt9BISx7pi9FSBKp8mlDTVc8m5LqSe9LCg+8N+MlsFtK0
	gDFm/JzNfnl3sVM+6C9sx8eNUOEKLYrI9FwJgBxcn/Otlmqnc7a3ka1U/EUn4Mu5dk9nXbU0UzdE+
	d16AIdF+hZSHh813AgTs6oSslctOxH8Wu170MwJiAj55HXHFDOhLFrnY64jWvXJILu21PSG7Bw96o
	fqAMce73RnLKB4GN64vNWTNSnsf0AcjorNgGQukD94upszLkA3I8zt1b2hpGVKfuDv15ti5pG7y3I
	dbI8M6sw==;
Received: from [83.214.222.209] (port=38970 helo=[192.168.1.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v1mBL-00000003y5E-2EC2;
	Thu, 25 Sep 2025 08:38:47 -0500
Message-ID: <fcdb0a83-3b1c-42bd-b58b-b501cfbf27fa@embeddedor.com>
Date: Thu, 25 Sep 2025 15:38:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "scsi: qla2xxx: Fix memcpy() field-spanning write
 issue"
To: John Meneghini <jmeneghi@redhat.com>, martin.petersen@oracle.com
Cc: axboe@kernel.dk, bgurney@redhat.com, emilne@redhat.com,
 gustavoars@kernel.org, hare@suse.de, hch@lst.de, james.smart@broadcom.com,
 kbusch@kernel.org, kees@kernel.org, linux-hardening@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 njavali@marvell.com, sagi@grimberg.me
References: <yq1zfajqpec.fsf@ca-mkp.ca.oracle.com>
 <20250925130729.776904-1-jmeneghi@redhat.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250925130729.776904-1-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 83.214.222.209
X-Source-L: No
X-Exim-ID: 1v1mBL-00000003y5E-2EC2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.104]) [83.214.222.209]:38970
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDfjBdf5/XK0AbxUIzW444sF0uLD1pCABeMwSbLTMohqgCZ3gqxbmB4Fh5Ezr4p5votDxVascy8z3F78TONA5sPFB+CO/Cnre2tMjMek1Tw8uOh3GxRS
 lRpqwAcI0nThmkspqkXvko3WlTXgyI03ZVpMVI+h6m4Ta+76M6ArQWcUH0mndvsPubaJAaEwqyQkqihXZa5qZgqYYLTMFFd5KzE82vprlDhNb51lK0rbcLwO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_144037_294936_04C7544C 
X-CRM114-Status: UNSURE (   5.62  )
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



On 9/25/25 15:07, John Meneghini wrote:
> This reverts commit 6f4b10226b6b1e7d1ff3cdb006cf0f6da6eed71e.
> 
> We've been testing this patch and it turns out there is a significant
> bug here. This leaks memory and causes a driver hang.
> 
> Link:
> https://lore.kernel.org/linux-scsi/yq1zfajqpec.fsf@ca-mkp.ca.oracle.com/

Thanks for the report. I wonder if you have any logs or something I could
look at to figure out what's going on.

Bryan,

Could you please share how this patch[1] was tested?

Thanks
-Gustavo

[1] https://lore.kernel.org/linux-scsi/20250813200744.17975-10-bgurney@redhat.com/


