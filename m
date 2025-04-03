Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67393C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 07:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GgThBuknXaD3lwbCXtPebulyQHktE8jqziVCkvGpKHg=; b=YoR0wTLCtsJoza2g96OVM5uazU
	nCiDVyF6CHWSfdLugFObfeq9MNg8r1bMpP1UCb9yH8dzYE22c2iByMaeKdP+NpA6/AKlQzMBDS0da
	w0jBf/RFXg1yeDlLDgFsFSEe1Blzkcm3rMmmacuyreLBl6KeTUtH+9uV/10laShn7tgi2E1f7ojsb
	0IyjngPdGkPRBM/PO+SW5gLsvIwJx+vILAvrTXIKrydTTd8JMjaAvF8Fe6eGgcEUBClMha4o14TO9
	woDDONp0bQG8phmsvj3YZU8tvaFBJtKp5RO0w09iUCz5oIxbLhDMP9UmaC8xg5blcYWzEU83/ZnFm
	QWEf8hDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Enf-000000084Le-3vWH;
	Thu, 03 Apr 2025 07:15:43 +0000
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Enc-000000084Ka-2eVB
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 07:15:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743664526; bh=GgThBuknXaD3lwbCXtPebulyQHktE8jqziVCkvGpKHg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=uz3St6b/C2YSQFNiOZ+8qKl2bE4pk3XPo3ejaa21CTWNKzpPmYZKfh9Bti/fP6S8w
	 OHwpwiJFbBCAuZertBtXl+ab86BMiTV6TXWBCoWeWQJ/exDeC244wZf+PnGrl87FHK
	 b20+5aQXcfAxZjTYommJHEf4lq2frm9KjxumRCP8=
Received: from [10.42.13.21] ([116.128.244.169])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 228A7AA3; Thu, 03 Apr 2025 15:08:40 +0800
X-QQ-mid: xmsmtpt1743664120tjvpap32a
Message-ID: <tencent_0B50E848464E942D6467F86F53C9DED88606@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjqmL7MHMzvCf4yMzMA6sLrx+XNuJIq/WDFmj19VAC4kGSYB/7QH
	 QggSR3AujGjYwbL52QY+TV+B0Ithj54H3+ktR6TgNoX4DFiogfaRtnRhepCugfhfNXZfCK3TjlU0
	 l+g18J4TBHWTlZUqOUGZ+B42osEFmv8SzZL5P+1umzFlAtEizNuRyux2CFzmQfkFDeA3HFyZuVPK
	 gejinWdMxHKlZ/wPx2VhWqFdX6vis3LMNF0ixPXt2hZvjRZ9fWHAOu4UZMfXoF7aUaWVAEITkEQt
	 DoIYwUjJ3PKXMVa1n0GqWhCSR5bp8KBIEyp8pqezKxGCTdppzRwRzv9QrK2qIXEW8Ha0U46ChP7X
	 YqfqLLoUNtuFlKsWFLWeY77Z6fphU7j/Uq0n/HWI/ap2+d+0uJNCE+xqS9H/IjL7Mxamy6HYd1rU
	 1JS3nrJl2LbLES3uEts+HoCby1O3OgLZJpf30R5w/DNeGINSH+PFhOe0q6uYbt5tQR3TXlVG8meJ
	 dJA3mE5YIBU/yPRMFRWyjKprcR1UXMV3KHvZFQslMloY8zJE/CLdXn9f2bGyeTA9vM6YNqAGJzN8
	 L8JDibWucgHIz+h9ZHMe/at1gq6afzDmVy7WddpvDczM7CsU9+ff5chuAUodROw1muGnM6JgGUJ6
	 rgEBwh1omB03MCmowjaGXQ05KfWVK+PTfOiymz9jOFzTTmGj0yEjqXuyUw2d4Dd8NXiVmZQ7b5ie
	 bUL8lG4Ff8ltbVmDY8DcpXRbvR9GEDDKjSIR7iixz/cRqjnY6qGlqOj/XhYkYBDtcdQreTypRN6R
	 YO2ISJWNUXd9xb5iE0Ic9SRJC5ZTnD7InbDmGPLnvOjGc8lUoOfiCj4lyH1VhrydV1KGEl+UUyks
	 OxnyevVhX3hOKKIXN7G/2hf9GHZLfhWlUDDqrF5RUjusW4QOMr6j4UKuqBgrTT/v9hcAF6WDOceu
	 TIf2Z2J6zESpgxl/7TJKHl1q2DS4g1s8FH3JvXnRc=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <d7b88e2a-7090-40a0-8bdc-9b60678e204d@qq.com>
Date: Thu, 3 Apr 2025 15:08:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] nvme: Add warning for PST table memory allocation
 failure in nvme_configure_apst
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 chaitanyak@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Yaxiong Tian <tianyaxiong@kylinos.cn>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com>
 <tencent_A06D513AE17E9D4B4AC66E84F447FE730C09@qq.com>
 <20250403042557.GD22360@lst.de>
Content-Language: en-US
From: Yaxiong Tian <iambestgod@qq.com>
In-Reply-To: <20250403042557.GD22360@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_001541_220215_C7A05BF6 
X-CRM114-Status: UNSURE (   8.83  )
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



在 2025/4/3 12:25, Christoph Hellwig 写道:
> On Tue, Apr 01, 2025 at 05:26:52PM +0800, Yaxiong Tian wrote:
>> +		dev_warn(ctrl->device, "Failed to allocate pst table; not using APST\n");
> 
> Please avoid the overly long line:
> 
> 		dev_warn(ctrl->device,
> 			"Failed to allocate pst table; not using APST\n");

Thanks, I Will fix in v4.


