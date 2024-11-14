Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8534D68B31
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HZDItl96dPAvdzyIDCP205086lplq3O3IdJ8ySUspxo=; b=zPzvRr/egm18V83NJ16X0QCxws
	o42ENzgo8TeBhrECq6lV1xdWiYMNdfOiu9E0TKnbuoFp5bwFaubaXVA28HLzYcHcqqylQonUKRNwI
	+pxouGM/klyfr3Pmjqcqem7VlT4CKmyBSPOrYc+QFWEV5Ks71aeIee+jAofCsVgYZ8ZGL88bj6wdv
	e/kuFEFHEVXg84cNnv1g9zBKGkcOlAcCM9cuIVJwLYeVCaMGADn39jRN3E1R2lgMGwWxgYanRJFNF
	4wIxsTUb4kUULVH6BKMts6EOzox0uJh5I/RvWpqjSMDJUquNQ/lj8Vdjk7CJdul2SEC/weFYVa7Es
	KuhHJ9JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBbqi-000000000Yc-35yX;
	Thu, 14 Nov 2024 15:33:36 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBb4B-0000000AF6m-0dPk
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 14:43:29 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-71e467c3996so565194b3a.2
        for <linux-nvme@lists.infradead.org>; Thu, 14 Nov 2024 06:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731595406; x=1732200206; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZDItl96dPAvdzyIDCP205086lplq3O3IdJ8ySUspxo=;
        b=mQ5tDD/WGvZzSp6ZpiEc1EBhE/o0NM12VNkwdiur/oxSQDGGg5hWNiTNlyfQ1H3eOb
         sV7uEvB+y5jsLsDTVBVBNf37eBG7b7UBCXxPzrFEm8H/UufcmsS+hpdgm/cfi3FoE4Dc
         06Fn22YoZCGSViUNdhm43KvGqG22AdfWYzn0H8zljbh9HbkvZ6RjBMk6Ze0teiE1MsHB
         un84/Kjz2RVJHZ4L71K/yFQ4NOm0/9q1/WzV6+RkdYDjpTn3+Y+ZNP1+dPm1bgvoN9HR
         Wm5EGdvFmB6q02G6m6rpwvD1k/fdFotFE2ZOjixljBAiTq+39w7x58SPa2ItiNnNeRP7
         Cy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731595406; x=1732200206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZDItl96dPAvdzyIDCP205086lplq3O3IdJ8ySUspxo=;
        b=qDTSr3dYe0vZYB1oh5OPR0bdErFMLP60D8ZK0VVVje72ovxUl3sJ5iMG63z3RP+/n5
         exWZ9SGXulv6OIKQQ4zh3JO1tbWpGZ3ASFJ8Z1u5LnfXDfYO78Y8MIZ+yzjF1Oc8KPI9
         U4UPMLzdlTcO19Fqg+cp1vY91hybMQJBHxOuLQiqtX5V/bwDnKjvWU4FelaBODdRP1og
         ui5scHuXRK0uxZ99oj3t0po8l+7WmBWok3/KTiXFxJXFmj9IwPgOWhs1XAg3b06nn9Gg
         bVDR3eMj6iCVE5iMYPjINs6QSsaBYKoPyp2fV7kdD4k/vDeftFHev56LljTE6wYa7My9
         LXjg==
X-Gm-Message-State: AOJu0YxZXrdC+6yd9/ds8USYeTdRr8xEP05Ttx2QjJKc7+vOajN3nkGk
	RfFJgPIY2mJQCZbo+aGNe3jEapmMPaCVky0ILDmp5SZVg0xO72iE
X-Google-Smtp-Source: AGHT+IF6ck6f23hoOlaKuSO3KSqD30+vZzeLJc33Swua3I/KFJq2FnxgLY1YF7nISGOANtP2VkUTgg==
X-Received: by 2002:a05:6a00:21cc:b0:71e:7a19:7d64 with SMTP id d2e1a72fcca58-72413279ea6mr26349336b3a.5.1731595405757;
        Thu, 14 Nov 2024 06:43:25 -0800 (PST)
Received: from ?IPV6:240b:10:2720:5500:4243:fe81:6c67:d3c4? ([240b:10:2720:5500:4243:fe81:6c67:d3c4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a9babdcsm1354146b3a.144.2024.11.14.06.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 06:43:25 -0800 (PST)
Message-ID: <26444a5c-8b93-4aa6-ab7e-891a83811afa@gmail.com>
Date: Thu, 14 Nov 2024 23:43:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: use BIT_MASK and GENMASK for NVME definitions
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org
References: <20241111170935.4540-1-ikegami.t@gmail.com>
 <ZzLZCzXfrLAP_RO8@infradead.org>
 <52a74c14-e95a-4065-9b38-8aae830ae239@gmail.com>
 <ZzWHRSFI2dS8O0sa@infradead.org>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <ZzWHRSFI2dS8O0sa@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_064327_216699_0288093B 
X-CRM114-Status: UNSURE (   7.45  )
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

On 2024/11/14 14:14, Christoph Hellwig wrote:
> No, why would it be?

Understood. (The reason is BIT() used more than BIT_MASK() in kernel and 
also still I think better to use the macro instead of the shift operator 
as below.) Thank you.
   #define BIT(nr)                     (UL(1) << (nr))
...
-       NVME_CMBSZ_SQS          = 1 << 0,
-       NVME_CMBSZ_CQS          = 1 << 1,
-       NVME_CMBSZ_LISTS        = 1 << 2,
-       NVME_CMBSZ_RDS          = 1 << 3,
-       NVME_CMBSZ_WDS          = 1 << 4,
+       NVME_CMBSZ_SQS          = BIT(0),
+       NVME_CMBSZ_CQS          = BIT(1),
+       NVME_CMBSZ_LISTS        = BIT(2),
+       NVME_CMBSZ_RDS          = BIT(3),
+       NVME_CMBSZ_WDS          = BIT(4),


