Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BFBC54E64
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 06:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pnkND0cH60WjL5KSA6lgd96B3CyqKxlQW4JrpQNednw=; b=qxHbMXeHnDZwuofFNCRFDJcuR2
	ZSpQQiYHRroSoF0vku5FwauVySAs072MXi+VbAI62ODmTiq/MlYB7hDFYPgCtapaErGTK6SZUeiPu
	J46Iv3Szw7kC0r6bbQ8RMpqKNcES0xh/OPfcp++57hPTMWhwUgOoYuftITJng0AUZ5QTsWrKmZ/5/
	zX18aTsl1D472+3FMZ9wvbf1Jp1gUH1xMqcLZWMsOgYokES72MJMdN+Wn5MjSqiBIEbFxDOE7zf9t
	siYHk5YOPPiqj5+Tud5ft4fqGY2f2DvNZu5crXAv936sRB5IdMC/9wUDlGIg9d76dOEKFaYtPWPva
	wXUv5HQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjeX-0000000Cm6W-0ODo;
	Thu, 28 Mar 2024 06:54:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjeU-0000000Cm4u-1zPa
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 06:54:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A1EBA616CE;
	Thu, 28 Mar 2024 06:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98B7C433F1;
	Thu, 28 Mar 2024 06:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711608857;
	bh=xvZg4ZS3GQW8DLAdIOJnu8XNRSmySRYLVwW4qbjaq30=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nC7KVS/2XGbuejz+ysCGa6NCJu/m75fpumVAGLsBNtFznjDkmA5j6pYMFDPHd3T9r
	 cX+dLKY0Yjwb1Qf6HQnpgz61yq83/FDLnlwki+npUuJ1VvWNgOmC4EUCErM+UbDa0S
	 66m8nas66bytJKKqDyjSIaxHKnyJTYB/c6rz1cJIXyjILxRYNpmRzuJjCJnHDnKaEI
	 JPmpaQV01eZRXgUsQxzS3Ur5Jh5m97wuoTNWowYYFcFdPFBOfnw3fvyLLZPBzvfKpL
	 0V453cljW6VuJ/ILjQw5JgJHI0a6Jy62DQUZ+dQtDNhmkk6pvBTUZtMZDlSVdUxqn4
	 vR7aR8T+R5suQ==
Message-ID: <141e580e-e465-472f-88a3-c97f2a6ce615@kernel.org>
Date: Thu, 28 Mar 2024 15:54:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 30/30] block: Do not special-case plugging of zone
 write operations
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-31-dlemoal@kernel.org> <20240328045430.GN14113@lst.de>
 <6035bad8-b157-4705-8ec1-80cc003fa646@kernel.org>
 <20240328065138.GA17890@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240328065138.GA17890@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_235418_594641_514B8A1D 
X-CRM114-Status: GOOD (  13.14  )
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

On 3/28/24 15:51, Christoph Hellwig wrote:
> On Thu, Mar 28, 2024 at 03:43:02PM +0900, Damien Le Moal wrote:
>> That is indeed not great, but irrelevant for zone writes as the regular BIO plug
>> is after the zone write plugging. So the regular BIO plug can only see at most
>> one write request per zone. Even if that order changes, that will not result in
>> unaligned write errors like before. But the reordering may still be bad for
>> performance though, especially on HDD, so yes, we should definitely look into this.
> 
> Irrelevant is not how I would frame it.  Yes, it will not affect
> correctness.  But it will affect performance not just for the write
> itself, but also in the long run as it affects the on-disk extent
> layout.

Agreed.

-- 
Damien Le Moal
Western Digital Research


