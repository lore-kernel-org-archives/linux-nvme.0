Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B052DE8FDD5
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Dec 2025 10:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x150ohOiZKjj0JH1SGEJ2xmrmckvT0TTgs5U+Y4eDkI=; b=4J/qJI2xmUvhQY/jZ6nz3TVmg+
	/9VwZ4tymgIj7kMXGmUnzIKMBLfYEZPdFslapvcs5a7L3VFa94EFPeBNre80ALLHqVqCtzCJpgXTy
	kR6SuVL6NfXroGS+Fi9fG/Bg1pEfYNi+Mx7PxmDBPEFDLhjj07wEtnYkhAzCFfOp+h+7O5YLHEMLX
	Zh4pqPb2XQHZLjVcNfOJ+myJDfY5PEcjoFUg3zK14HRzVMJxTY+tMl0kzvl/Sa2uDWV48A7JcG9v9
	J1DDGUsUO9xzwV4rF0Co1/hXfrAnmiFuqZ6msqWJvuhs+lJo02U80c+IRP0xrD3DooSV3v90kMSQn
	3XQKsI+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZRed-00000001rfS-2bpm;
	Sat, 27 Dec 2025 10:36:11 +0000
Received: from mail-ed1-f53.google.com ([209.85.208.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZReY-00000001res-3y5M
	for linux-nvme@lists.infradead.org;
	Sat, 27 Dec 2025 10:36:08 +0000
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so8981134a12.2
        for <linux-nvme@lists.infradead.org>; Sat, 27 Dec 2025 02:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766831765; x=1767436565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x150ohOiZKjj0JH1SGEJ2xmrmckvT0TTgs5U+Y4eDkI=;
        b=lF9vGq0zO27kmY+ePKjiRfJ31w9XhK1+fh+ZodQfbnLLDvfVMlAFbG8EjhrYZ/Ob4C
         zmk8qPzdxgo/RcQY02nLO8dKIFvDVDiiat669PXe3AKq6w6MQAfEA0nNB11l7Rz9nHqQ
         4Fqy6mzIZNZr8J+zIh8R+8DOmWJmjwpt+XNWCnnH+u40Ov+xN79xQRBz6r5cSmAZe9R3
         c5YgyxdNWs4UNYw/BknJM6upRTX6MrIMtyrTRjqv1HAibuvD+jbkTUAMsHiIk9VDVh8t
         2+6q/fvwFg2ey5EJ2gZRRGF0twQ+NsQEfwQORNt1kLjYJ0S3iminsYS3gPQ0LV1CI9Fj
         ahdg==
X-Forwarded-Encrypted: i=1; AJvYcCWN4i950hzbAwCWLAQpAdS7DF+/3VUFodUpv+bbDowoZWG21apMCoKzCl2izc97ERHNi1vsk+1m1bwk@lists.infradead.org
X-Gm-Message-State: AOJu0YyQufcNFWkgMGI47pnD0rrnqviFTcTd4uO4B9Jel1X9hFUx4lMy
	nD6e6vFWTPGBwv22nS+OBCTcAWlhPsYty7KdSXnpoqrpkZnrXiciLnKY
X-Gm-Gg: AY/fxX69qCq64OQ5rOk+m7SFlpnimuDr8GMoFCTsS5nUj8c7IBKghgh5abexP3n35dn
	CTBdfxE+PTNba40yM3tWA++UxfIjnxH0j9TjTWDOcu7kYyBPPtTn0CUz0HDWrGHUYTqg3KJKb6a
	3dUzmau6YRX9I8XfRXIWWG+mH5QRZJV1swf6H6KJmgd3QA25L+fvk4+40rOwO11SytbU/iT4oi2
	LGyw7g/SmEkkUQIXOWRb0ah2VwwVCAC1gYnmW07Apdeq79ZvhXSR2fAX3/u5kjQ7tB/hYWM1BCF
	/aSxlprM8RL/bswXwNBrIjye0bPdhYjDKUFKt1inI76RzqPkpZPqE7itU4sMi/S3qSuVh1WI7nM
	iySRcWmGv9daaHz+GwnM/uv3f+ogMVeryBdXS/J9uin2lOKzIwL3NNs4kJ2Inm2EDbcHHTFW2zV
	fUWu+MOUnntWqDuLTuwwCErqqDRd7gnruKI4PmdEITigs=
X-Google-Smtp-Source: AGHT+IGVKayjBEyqqDuVKg64jiyyc4F41ac5DZNsU59a9LgIPWAfgCq+L4zR4zjTGCr9BmzQUJXfUQ==
X-Received: by 2002:a17:907:1c17:b0:b76:31e6:2ee1 with SMTP id a640c23a62f3a-b8036f65331mr2462582566b.18.1766831764759;
        Sat, 27 Dec 2025 02:36:04 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab86cesm2660242066b.19.2025.12.27.02.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 02:36:04 -0800 (PST)
Message-ID: <8d61f3db-4294-4032-8c38-428f902c48ff@grimberg.me>
Date: Sat, 27 Dec 2025 12:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/14] nvme-rdma: Use CCR to recover controller that
 hits an error
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-12-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251126021250.2583630-12-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_023606_995170_EE3592CB 
X-CRM114-Status: UNSURE (   4.20  )
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

Same comments from nvme-tcp...

