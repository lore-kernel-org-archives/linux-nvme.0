Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EE6C7EE24
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nmi/PPknLe5NcPV5GoTVPuKYHIzmi3+CPOd87Hhbxx8=; b=4qK7/8LTN6upUciWNejDuqpSjh
	CIfYFMqcrRQW6jCblV4n2my6AXlQ4taX9jDNT9eHQKJydKcj2wGNFAscVULzXzO2iRwthUP1Or6yt
	Qt16kP0g67/K8Lcj7kMYBRDTp6W92YhB5rcL8GeUqjBzwEn7q4A2G4nhjXUPR806Ne3GNSmG80JGv
	fCiNmfBLoPgGPsVm64tk5XtxZmQM1Ng+9nHTz3j6k0C80zsTsGM4QnNoqn4RVW3DtaWqoliJvrP4Z
	qn4vZvjkst6ponC8GitGMqwzb+imL3YWI9nuiG7XGXlb9fkV/em2q/UFeVKUCSWfq63me9P2g+AgE
	BiKw3/Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ajx-002dTm-2Y;
	Tue, 06 Jun 2023 17:45:05 +0000
Received: from mail-pg1-f171.google.com ([209.85.215.171])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ajv-002dRv-04
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 17:45:04 +0000
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-543cc9541feso1224033a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jun 2023 10:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686073501; x=1688665501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmi/PPknLe5NcPV5GoTVPuKYHIzmi3+CPOd87Hhbxx8=;
        b=LXhSRXibiLk7znKr/D3FjODhdvZxzuNETTVSld2gdwFOmDWTJs+L8fLojNNj+G0nhJ
         UX/j8ik6sg9FiOK/yz+N3tW8hH4n8y6tnkf9adRfKxUNLuwRx3/BXapnCvaFRmEIs7cN
         dlxIIHAemIRXTHCt9VjejtRdd+/9EnPltGfiymqlRwc0ncK2Y3tkFnDXNjAp7p+WOTuF
         KD0YKmKNPs+LjcWy4d3lsbJu7N62RFZcKJndAT8BI61J3fj4vXxBg+lteXvnasV/rQBN
         NZrC+N8NciAoeRrYbx+Gmehaa7UB0bfgUoZuAsHR6V+1ZS+A/3BTGQD8O37Hb0eIZe/9
         tDSA==
X-Gm-Message-State: AC+VfDwOteL2yYHxH3HuFypvPcWdozuzhDK8vh0kpZnnnHcN8jFHZEmK
	dpu+cEIkW3HzVU6gYwqIcMY=
X-Google-Smtp-Source: ACHHUZ5fAcNgcADCkYRu+xZLEJI/xVmrRhz62JDO1XlAcIckIgnvK0ZOSG42WS2yq3aifD/6GR1Uqg==
X-Received: by 2002:a17:902:c949:b0:1b2:499f:674f with SMTP id i9-20020a170902c94900b001b2499f674fmr335469pla.25.1686073500922;
        Tue, 06 Jun 2023 10:45:00 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id r19-20020a170902be1300b001ab12ccc2a7sm8784309pls.98.2023.06.06.10.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 10:45:00 -0700 (PDT)
Message-ID: <bb8c8d9b-0fcb-4ba2-eea7-6954d8723d1d@acm.org>
Date: Tue, 6 Jun 2023 10:44:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH blktests v1] nvmeof-mp: Remove nvmeof-mp tests
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
 Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>
References: <20230606075443.17437-1-dwagner@suse.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230606075443.17437-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_104503_064693_81CCF826 
X-CRM114-Status: GOOD (  13.04  )
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

On 6/6/23 00:54, Daniel Wagner wrote:
> The nvmeof-mp are designed to test a NVMe multipathing setup using
> dm_multipath, which was a configuration RHEL shipped. In the meantime,
> RHEL switched also to NVMe native multipathing which is tested with the
> nvme tests.
> 
> The nvme tests cover all the use cases which are testes by nvmeof-mp
> including the transport failure, see nvme/040.
> 
> During LSFMM 2023 conference it was decided it is better to drop these
> tests and reduce the maintenance burden on blktests.
> 
> Cc: John Meneghini <jmeneghi@redhat.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

How about Cc-ing the person that wrote the code when removing code? 
Anyway, this patch looks good to me.

Bart.


