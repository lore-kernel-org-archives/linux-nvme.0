Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B6DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gSsCl/XOESNqiNL4KQnFJzGeYGKZJS/OXefqIbgZZJY=; b=Vp5nyFTDZcFjS0rZBuw6xOMso7
	0U5Ap8f/o90KA/BRtf0Bg7kMLui8pZUTibVI1Wz/ieWNQVuhYC8m/mf0pg5W+xiI6uEceDWY0deOk
	HJcPoqRIJ7qjG/+7bRUvblkD2JCkDDjmV9dHFF2u+RUe6RhrYqugWAb6PLBN1PVQoBhRxQlTZf+ew
	4wOkwPvEO3N5voW0vtVw5fqQKYld+TmCo5sGhmthZy5EgIFRpWy8R6x2MvIQw1vxSax8QWV7YrOtn
	0137iNvvFa7LKOdwU/mmBLFPZneRVkdIn1K1uaEhpeAm1AHpX+HEtvoEPxQjmxytNIV7KoAQFMPoE
	+F0jn0jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPqJp-007U68-KJ; Thu, 03 Mar 2022 18:36:53 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPqJl-007U5Q-Oi
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 18:36:51 +0000
Received: by mail-wr1-x433.google.com with SMTP id x15so9170760wru.13
 for <linux-nvme@lists.infradead.org>; Thu, 03 Mar 2022 10:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrikto-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=gSsCl/XOESNqiNL4KQnFJzGeYGKZJS/OXefqIbgZZJY=;
 b=xv4zkThkBLX7HuXqZhTfHDYEZKNHRIBCccoLghrxv746zdKoMUitS4RnI/cGuGlDPQ
 vfANpAF7D/SOQuhdavvwEHHH47Qe4rpi+IsklXWeODKqDiVmFthh1F6OigEyCr/o27Gd
 Zlx44ZPUSEX8vFl2XZ5eEXc5WRHRksczAMyu2nxfK4OXd4FLzkuC7Fx+PO2LKk4Sj7k2
 lAVUF6SBc5gRRYNmWr6bFsQFcG3+ERQzr4uXhWYF+qnNkFDC0G+4pOrPugWGltcGxKei
 uHeqxuFvKXtDxibeNqrmYwAlqmHnsFQKAUqkvIDqpRvMP9f5y/5Uw4MYYGF+P4M4GCG4
 9b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=gSsCl/XOESNqiNL4KQnFJzGeYGKZJS/OXefqIbgZZJY=;
 b=K7Ow4spO3uxqQZBRGvHg7zBND/r1gONt3DvA0KShCj5XPKOUWJwofKnaIc8sRR5Ho5
 86c8xkTJkRIPxcVFRm0xjVL0pViIjILqwDSnnDa9qf46A8b16TQ1PqqZlei3AgWAtk/k
 +ZOS/Fcfi30oadKxDrlQMvuLUslLKKissiWafGZklzZDepBc6QIFfUaygqwVGEIMDb4u
 7AqTLgbWAyDA6uU/srCQeRcY9OslU8AYsVMwKkA/RM5bEqRBbQS6wTBx5a12N4xFIF80
 2vriRXr6p5XuPhVNGfrQBrC0OtQj1y0ISeCrBHdGaJJsUMKJCcBTIIkXNGBZii/yn+4q
 eZtA==
X-Gm-Message-State: AOAM533acIhljw6bPI9zXkqLzCeYwPHxoSolW1YML4Ymq6A9FK+o7Tm9
 v2qzU7ybYZJoOZEXe7okOieHHA==
X-Google-Smtp-Source: ABdhPJxWp//CMSQXMH4wlOTWsuUAaFU8DcmiZw37tn30FWgGhLmSgbx50j5GThznhd1HjqQ4Zon/5g==
X-Received: by 2002:a5d:61cb:0:b0:1f0:2598:88ff with SMTP id
 q11-20020a5d61cb000000b001f0259888ffmr7318696wrv.444.1646332605416; 
 Thu, 03 Mar 2022 10:36:45 -0800 (PST)
Received: from [172.16.10.50] (213.16.240.129.dsl.dyn.forthnet.gr.
 [213.16.240.129]) by smtp.gmail.com with ESMTPSA id
 x15-20020adfdd8f000000b001f0473a0a3fsm2705941wrl.14.2022.03.03.10.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Mar 2022 10:36:44 -0800 (PST)
Message-ID: <0e63b59c-779c-d85b-693e-79d2924acbe0@arrikto.com>
Date: Thu, 3 Mar 2022 20:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>,
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
 <012723a9-2e9c-c638-4944-fa560e1b0df0@arrikto.com>
 <c4124f39-1ee9-8f34-e731-42315fee15f9@nvidia.com>
From: Nikos Tsironis <ntsironis@arrikto.com>
In-Reply-To: <c4124f39-1ee9-8f34-e731-42315fee15f9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_103649_980793_287E07B9 
X-CRM114-Status: GOOD (  12.79  )
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

On 3/1/22 23:32, Chaitanya Kulkarni wrote:
> Nikos,
> 
>>> [8] https://kernel.dk/io_uring.pdf
>>
>> I would like to participate in the discussion too.
>>
>> The dm-clone target would also benefit from copy offload, as it heavily
>> employs dm-kcopyd. I have been exploring redesigning kcopyd in order to
>> achieve increased IOPS in dm-clone and dm-snapshot for small copies over
>> NVMe devices, but copy offload sounds even more promising, especially
>> for larger copies happening in the background (as is the case with
>> dm-clone's background hydration).
>>
>> Thanks,
>> Nikos
> 
> If you can document your findings here it will be great for me to
> add it to the agenda.
> 

Hi,

Give me a few days to gather my notes, because it's been a while since
the last time I worked on this, and I will come back with a summary of
my findings.

Nikos

