Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45270C19F2D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Aug 2022 19:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tEEBECMt2JMCyk8XPkBX4uFGE3X1j9GMANI0TyJE5wc=; b=4jQLa6debOm93kv//Yr0kbqhoR
	hzzrH1wy1D291DkSoXwCqs2BcuwjCDYmzwmKKHHNhsA0S5yejiQjy5GyHDMPPK6T+4H5o0uGX5YHQ
	IjW+qXb+ZlQBSStVkj+yhHxFjgUmv0FhtwDAr+7VUUky6lem8zoE0oKwcrz3QhtGuWRjNkjPg8m+X
	BeK7yxwZCudp+BAL8oX63lRGo8lkytWQ3HLSLYPKaxNz7tDjXbGJa253E1pc7oXkyEUeJ2zlzhLki
	fVU2R8/TQCjcQSISN9c2SwPUEmqwpE1fHrllo2nFiHXvu/XzDtWQ0SnmXOpL8Nj/i2uQCC6TBd4Hb
	NlDLn6Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLUwm-005s5d-IQ; Tue, 09 Aug 2022 19:31:24 +0000
Received: from mail-pj1-f46.google.com ([209.85.216.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLUwk-005s4X-R9
	for linux-nvme@lists.infradead.org; Tue, 09 Aug 2022 19:31:24 +0000
Received: by mail-pj1-f46.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so1796319pjz.1
        for <linux-nvme@lists.infradead.org>; Tue, 09 Aug 2022 12:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=tEEBECMt2JMCyk8XPkBX4uFGE3X1j9GMANI0TyJE5wc=;
        b=eYYJ+7a5qrgA1/i9f7kx6ClIWcekvy2fFveHboCxA7e5tuamqeKG2BrtOM9pYpljtP
         UTfg6HEiunC8dMjc/wYHhXYvCTibZ+0TpCJkAkpMLPb9ryigfHwaheNBqceid2aMgFTU
         tZiuon+kObLQAcbmJ1Qj2KznlVD9ACuRuA5pqhzrIGG635uE+mSlkER3YcEDcMXE9Xut
         o34tKOP121pBRzvOf/mjpGMwzawVEytbYP4nMquxFS8rlMjh+Cyy4OsI8Rwf/YH+jk0R
         fgvm8ng+RA6+L70nvsDs4mpY8abH3dnfa2j+RSzQflxM2Q0XH+jJSccN/HG1mNv3eFe7
         le9A==
X-Gm-Message-State: ACgBeo3kFtrXKR/+fGuZHn56lToZcnhOUs8ageYHGgugxZ1g8Bhw7JoF
	tRoalK0NNtxBcyvLPOY9ZHw=
X-Google-Smtp-Source: AA6agR5ZL0koW3EeIcBB5kMJj6MK9Gs4GzdlJ/nY6Ucb+iCE6MSghHnDdd0Y6rdswP+L8s03kMtJug==
X-Received: by 2002:a17:902:e5cc:b0:16f:1153:c519 with SMTP id u12-20020a170902e5cc00b0016f1153c519mr24584729plf.151.1660073481696;
        Tue, 09 Aug 2022 12:31:21 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:61e9:2f41:c2d4:73d? ([2620:15c:211:201:61e9:2f41:c2d4:73d])
        by smtp.gmail.com with ESMTPSA id np15-20020a17090b4c4f00b001f31d6fe0f3sm13133214pjb.57.2022.08.09.12.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 12:31:20 -0700 (PDT)
Message-ID: <c6e96f39-69e0-b1f3-93c5-b9912e2af270@acm.org>
Date: Tue, 9 Aug 2022 12:31:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 14/20] scsi: Retry pr_ops commands if a UA is returned.
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com, snitzer@kernel.org,
 axboe@kernel.dk, linux-nvme@lists.infradead.org, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
 Martin Wilck <mwilck@suse.com>
References: <20220809000419.10674-1-michael.christie@oracle.com>
 <20220809000419.10674-15-michael.christie@oracle.com>
 <20220809071632.GA11161@lst.de>
 <bf55356d-24fe-7a8e-c766-cdf33e7304c2@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bf55356d-24fe-7a8e-c766-cdf33e7304c2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_123122_904455_CE8A8ED8 
X-CRM114-Status: GOOD (  14.31  )
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

On 8/9/22 09:24, Mike Christie wrote:
> On 8/9/22 2:16 AM, Christoph Hellwig wrote:
>> On Mon, Aug 08, 2022 at 07:04:13PM -0500, Mike Christie wrote:
>>> It's common to get a UA when doing PR commands. It could be due to a
>>> target restarting, transport level relogin or other PR commands like a
>>> release causing it. The upper layers don't get the sense and in some cases
>>> have no idea if it's a SCSI device, so this has the sd layer retry.
>>
>> This seems like another case for the generic in-kernel passthrugh
>> command retry discussed in the other thread.
> 
> It is.

Has it been considered to introduce a flag that makes scsi_noretry_cmd() 
retry passthrough commands?

Thanks,

Bart.

