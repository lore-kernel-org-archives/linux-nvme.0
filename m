Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68B0C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rlALRL2VGRCqLuBn7IS2oiiWh31fR9fnjGFQu3I0EVk=; b=mG/E2iESPBYmN/Rw5eE07RkZeH
	uaGgPS6vmQATIvr4GgibBqnvdqDQ4YLj4ulnoJDSY1EqoUWLt06wgkttvNWp8TnplWEpSAyPja9hA
	kM60m2cBjNjfpPCXoOLrrdbI0JkKSBLFDGmaZTpScliQPMvuywK4lxKLOr+win2YjHee09HjZsXVO
	DN0RtZibiAajez6VNU638o5ft+NXqZfUpYefsGIrH0Cu92TRB0H13+XOjDEQN98BylZR+jscC/DPC
	+4hznvlaUs1IPseh9DlFbf2kNDwY2Lw1YrERmZJue/aoVt9Nm8t6axvuokp5+2knFULmEeKLHR3w5
	C9dsP/RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6KD-0000000GM3C-3uIS;
	Wed, 17 Apr 2024 14:31:49 +0000
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6KA-0000000GM1C-2vBH
	for linux-nvme@lists.infradead.org;
	Wed, 17 Apr 2024 14:31:48 +0000
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7d67d1073easo48890939f.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Apr 2024 07:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713364300; x=1713969100; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rlALRL2VGRCqLuBn7IS2oiiWh31fR9fnjGFQu3I0EVk=;
        b=UVBnhbpVo7n01XIKceJk4/kwJgGcajz/a5OWmA4VsRcx0M946oTIfN5CEcXbBPwmOd
         G8wY/kyHkMrr+Vl1u8WrgYvCA2TbizfVONUaXnOJwoxh1UljSBMkfjVtO7vfR87AeKA0
         KQL8H9Canf82jDMzWf4O4IvG5CbIv5+30hqCnIU3zLQRXn7ibt9Ak7a6Dc2fySpydg8r
         TABkl7tLJYh3KQooR2w0MTwgful0fBo5Mm1Iju/sf52wzoUc6Vlg1OLeUiAggnFMLbHj
         09jesmvwIr3yXUbFfWlfYSi3ZVbNkp9Mtmz9n0pU7wzjRMyq5P4CIvweuoojBE/AHBRF
         HvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364300; x=1713969100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlALRL2VGRCqLuBn7IS2oiiWh31fR9fnjGFQu3I0EVk=;
        b=JpN19QDG/vqmd2r10M4k20rJlZzNtPQ/yJSFW79e4YWhzbXxR7CIrDEuGG5/IWljf6
         KfQ3dftFS0gmrlGfjkxEiRLlR44NVB1REKX+O+vujGuuSNp7HL8NHy+uX2tZFGb2DfNb
         8sK9Fn6TyjSccObk0wUT3FAuZqpB3QvsT0QHa3wWB2XaGs74dVPVRI2+a+Yo6YsxE7un
         HmX0OBYNEiboqOVg3A/ohFHDH9QFLPK9WX2KWWUYEXyQVyinE20723BVeJq7P5jOv3M5
         Cpd65fELY+3OWPyN4w5DfGvRNGT/3GgM4XE9Zdv1kWq9t70oD8JfjkzpMzimo75Kfybb
         yUOA==
X-Forwarded-Encrypted: i=1; AJvYcCVyiaq5EZ/jjqWGqh3JkYpIIXBIc9B6+Uw4NBOYEo9bzFxM7e7Eh36rg2TpXGeqi/bTBzBYH5VUDvyAb7Tm+UVd2gP/B4Y9mkJndMAo5zM=
X-Gm-Message-State: AOJu0YyQuTc+ewNwGe0SLBbp4JONNxMr4+EUHvaieJAEY3Ih+jOu6bRW
	YDVUlShG4pCpGHSsrh1uxfQwbOhcx0mWp1tYYaS3HtisNdmn2wU2wQJRcmKsCy69gRAe7uIT3+i
	H
X-Google-Smtp-Source: AGHT+IEId4AwbynAFvH3JQmd+pUOl/E4aF9Kci57NS9/oRH48bFTTz++860ot4vt/a5TmJ7kfCzPmA==
X-Received: by 2002:a5d:94c3:0:b0:7d9:892f:389d with SMTP id y3-20020a5d94c3000000b007d9892f389dmr8564864ior.1.1713364299933;
        Wed, 17 Apr 2024 07:31:39 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id lb8-20020a056638950800b004828a615e3dsm4635752jab.11.2024.04.17.07.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 07:31:39 -0700 (PDT)
Message-ID: <7a926cbb-51f9-4e03-b737-b4434b1270dd@kernel.dk>
Date: Wed, 17 Apr 2024 08:31:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-cli spdk plugin
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Cc: Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Tomasz Zawadzki <tomasz.zawadzki@intel.com>, Sagi Grimberg
 <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <xulnfwru3jfl2nooq27yym7nx3cdpxqslzqz5nvwnkymncapnt@pzascju2tmvf>
 <20240417142610.GA31809@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240417142610.GA31809@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_073146_858332_E593C628 
X-CRM114-Status: GOOD (  14.02  )
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

On 4/17/24 8:26 AM, Christoph Hellwig wrote:
> On Wed, Apr 17, 2024 at 10:33:17AM +0200, Daniel Wagner wrote:
>> There is a PR [1] pending, adding a spdk plugin for nvme-cli. The
>> problem this new plugin tries to solve is, that with the recent change
>> to use sysfs only for discovering the nvme subystem, nvme-cli
>> lost support for spdk.
>>
>> My question is, should we have a special plugin for 'list' and
>> 'list-subsystem' or should we try to get this somehow integrated into
>> the existing code? So that 'list' just works?
> 
> І don't think nvme-cli should deal with anything that is not driven
> by the kernel nvme driver.

Exactly, why on earth would we care about spdk at all in the first
place, nvme-cli or not.

-- 
Jens Axboe



