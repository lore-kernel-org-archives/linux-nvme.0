Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993B9C369D8
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u8I91YH/aI9uF9ro2Vg6hlbwmxJoyFD3QHMBrx88C5M=; b=4MI3SzhxAyaGzhkio8yCj9aqZs
	jcjR+O9Bg3lZ3/hJt5KklLKEFb+6/z8/ntPxxL50HIenDiHMrnBjWVw25Xqzbl8eK6rrf0Mj7WJAI
	wZFfYr6dgY/pZ6FBL50LJLgM13xLAWwuVQ+TdBsETRJndCK4d3gmA1X1QM4COUX/CpT1ltUgG5U2v
	RwKngFcPEV9yNxwK6T85R9yU4qSMDGiO0I5P/8q01+CVHeUEHxRy7WeFr9ixtaq4TOB/A7ErNIRQ4
	3PJP5jeh0A6yOl/Xwk2OpUGJdcxHOl4TmJCS0byA5jOvCL+b26cW9pCj973mfHZL4UGLb+/lb+d+a
	JhRF0uJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7GYq-00000007vOo-45Xr;
	Tue, 22 Apr 2025 16:33:28 +0000
Received: from omta36.uswest2.a.cloudfilter.net ([35.89.44.35])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7F6A-00000007bTr-3NyG
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 14:59:48 +0000
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id 7Bpbuaan2METl7F5xuIdMw; Tue, 22 Apr 2025 14:59:33 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 7F5wurcOFh9Zx7F5wuTLoz; Tue, 22 Apr 2025 14:59:32 +0000
X-Authority-Analysis: v=2.4 cv=GODDEfNK c=1 sm=1 tr=0 ts=6807aed4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=DefJii25N9YVshmqbOOoLg==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10
 a=53fDKlUhlIHvPVJ8cPUA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u8I91YH/aI9uF9ro2Vg6hlbwmxJoyFD3QHMBrx88C5M=; b=XcGilj0AjEwgk6rztMMfyPftaW
	B4A3NhWYhtaqCeAFDSCvxxYK91FvBzq847M06Th72r1Evfd43gHmOwLS6LhO3kaVIJyrz65eW2uoe
	Qudq3438pOfktav5RGhh0/FHHJMI6gvk+eheLqP+PEyCXMaX71cSp4CIkZeTtuUb6cGfSk9TiPACs
	PWKipByUkvFDpcj7ydgYkfjwISDU9mIeCSC3nsBp7DzfxXNYN9sLryOK64v8t7+Np84DIdNkW0y2c
	jV0ple0xqkWCmGiDPsjgMY5bviyG3AH7s2GdVSt5bTa/LUNia4aMl6VEUGwoX7ObfxgliNww3iOBM
	ppl0aY0Q==;
Received: from [201.172.174.139] (port=59040 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1u7F5v-00000003hmo-1KqF;
	Tue, 22 Apr 2025 09:59:31 -0500
Message-ID: <a478dbd6-402b-47ef-897d-3e73abf80a97@embeddedor.com>
Date: Tue, 22 Apr 2025 08:59:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] nvme-loop: Avoid -Wflex-array-member-not-at-end
 warning
To: Christoph Hellwig <hch@lst.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <Z-axRObjXYjIHGQC@kspp>
 <a1c6fd4e-69b4-4698-bc5d-ef02cf7312e4@embeddedor.com>
 <20250416054352.GA25107@lst.de>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250416054352.GA25107@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.139
X-Source-L: No
X-Exim-ID: 1u7F5v-00000003hmo-1KqF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.174.139]:59040
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIfj/0UezWGfK1N7Z0pzBy3CfNqGWGLxPX12thp2aYZ8EhI08wNu23ijEpOiBkd87Mn64GY4TuSV4G39Y4Z/uYUkaxisKp9bkEX4BcfY6PCaR8dK7U5J
 1QqVKEpwVoRTtCvqJjJHC4tv2xxI9T8RhyCWlxybcmY5KwZswSMfdxnZqvrd8lSTtR5R4kIhC7zRF+LHTIM/q4wPlaXqBiA6s4vvHZMSmqgmP5T0KPNf48Nu
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_075946_875225_C30698D7 
X-CRM114-Status: UNSURE (   4.48  )
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



On 15/04/25 23:43, Christoph Hellwig wrote:
> On Tue, Apr 15, 2025 at 06:20:03PM -0600, Gustavo A. R. Silva wrote:
>> Hi all,
>>
>> Friendly ping: who can take this patch, please? :)
> 
> This will go into the 6.16 nvme branch as soon as it opens.

Awesome. :)

Thanks

-Gustavo


