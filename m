Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A149C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jan 2022 19:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ba+ZTTm9dUGfaeSvRk+qlfqj/OlYP9s6XSq9bd25RTY=; b=s5cPy0pgh9B8VFYajLQMxPGTgD
	Kx2B2W9PJYtlSEfpjvjU8KqlquynmEkP9I0xoBpGUOJ8Zshw5Xlus1qt7AwdYk1WagUtODmBL6nkl
	2FQNIxfcK1aDmP6hNs8XjVUkMtOvan8GbH4TEt+JLwGBZgi2MV3V2HtDQvmR5jwP+CcwpWOG88WDD
	Y+W9hbGzSJtTJmULT0d8np22Pr4D2UwVnlPuquVUkdND5aeFbuVNv7xBKTY4qKV7fjtqQyoCNQsX4
	1oLHPHn/RqeGqJ67egMM5c3Lppecz+2XNntj/VSqC4YwslT25W2fbPvCEvtTaOZs66jNh3I9oYi9V
	pVAL/Z7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEby9-00AUMe-2R; Mon, 31 Jan 2022 19:04:05 +0000
Received: from mail-pf1-f172.google.com ([209.85.210.172])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEby5-00AULA-Rn
 for linux-nvme@lists.infradead.org; Mon, 31 Jan 2022 19:04:03 +0000
Received: by mail-pf1-f172.google.com with SMTP id i17so13638894pfq.13
 for <linux-nvme@lists.infradead.org>; Mon, 31 Jan 2022 11:04:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ba+ZTTm9dUGfaeSvRk+qlfqj/OlYP9s6XSq9bd25RTY=;
 b=SADkF5wLQhEAwoGzhWgnb8852Us1GZjWVi/TJ6uOERSfp9u25YWU9lXrgg3NakKN1k
 B9EVhynNWH6fXwmF4Gjlt902SO3mpzeRTFkNTfN8b7TcgyAw/8TQtn73PCJlji7rDhcx
 0gPT6ZmiD9Bt+eErdYZMclkSF4HWr1nIv+oH1H2Gwnv7tTS1VRjMrm2G10zOSBLcEZTU
 JPFNB3Qf6lLyfSRUVORfHfmfEOYP0QN3YU6LZmfF0ffQoby4TYuHS2ihEfaCHkClnjmp
 rhV3ZNjtFKZQHip4SOLmwGXAUrcFmicxVCSYy6pQqDCWo2n/LxmtxnJx41rxhL3b6ufE
 cL4A==
X-Gm-Message-State: AOAM533zkcdajUU9+z9ilXk+VkBpvaJBE2uV4uqusJlMYxe+M8+dILVX
 sqK8dqQwBJPD5t9j06nZ3+k=
X-Google-Smtp-Source: ABdhPJzQA22tXEk8X4OPms7oAF0wKkcs2v8eBD4LAyDqrpj0MnwPbwFxejGQ4ckny7zBvb+xVPqt/g==
X-Received: by 2002:a63:343:: with SMTP id 64mr17733875pgd.463.1643655839828; 
 Mon, 31 Jan 2022 11:03:59 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id e30sm5686912pge.34.2022.01.31.11.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jan 2022 11:03:58 -0800 (PST)
Message-ID: <59a907b6-596b-402c-b619-b0f5b6013dff@acm.org>
Date: Mon, 31 Jan 2022 11:03:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
 "martin.petersen@oracle.com >> Martin K. Petersen"
 <martin.petersen@oracle.com>, "roland@purestorage.com"
 <roland@purestorage.com>, "mpatocka@redhat.com" <mpatocka@redhat.com>,
 Hannes Reinecke <hare@suse.de>, "kbus >> Keith Busch" <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>, "clm@fb.com" <clm@fb.com>,
 "dsterba@suse.com" <dsterba@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
 "jack@suse.com" <jack@suse.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220131_110401_959943_53B782A6 
X-CRM114-Status: UNSURE (   7.70  )
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

On 1/26/22 23:14, Chaitanya Kulkarni wrote:
> [1]https://content.riscv.org/wp-content/uploads/2018/12/A-New-Golden-Age-for-Computer-Architecture-History-Challenges-and-Opportunities-David-Patterson-.pdf
> [2] https://www.snia.org/computational
> https://www.napatech.com/support/resources/solution-descriptions/napatech-smartnic-solution-for-hardware-offload/
>         https://www.eideticom.com/products.html
> https://www.xilinx.com/applications/data-center/computational-storage.html
> [3] git://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git xcopy
> [4] https://www.spinics.net/lists/linux-block/msg00599.html
> [5] https://lwn.net/Articles/793585/
> [6] https://nvmexpress.org/new-nvmetm-specification-defines-zoned-
> namespaces-zns-as-go-to-industry-technology/
> [7] https://github.com/sbates130272/linux-p2pmem
> [8] https://kernel.dk/io_uring.pdf

Please consider adding the following link to the above list:
https://github.com/bvanassche/linux-kernel-copy-offload

Thanks,

Bart.

