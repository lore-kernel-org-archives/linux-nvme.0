Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EB9C47DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Feb 2024 12:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Subject:Cc:To:
	From:Message-Id:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=1VsrEW364NLFbMOpVdWrVpVClR5o3UGDnlsGXHcP8Ms=; b=A/GStPpgFfaEqI
	pqqraYQsn0nWw9SkGs5c6ahjfmrv5ZCXn0TF9YVn0INPefBRL3fb+AfcrtVpIMzv7h/io4Oet+DvV
	sdMdmMxw/kqmDuKj1kWoyUb1mZw19zhIefNmcKvteofLSwxUT+7OH1WGH9PwfUYUqDW6a7wiz2B2E
	PzlRB2VRrl5YK2mjczfy3p4ex46HoGz1dvWcN8Z/WyD2yuo/w7gfh4qfxw+AiC8851ZPoruL2woeX
	BMNyGDk3jyTjDjbv9l6yKAjOHK/nJMWMDiOXMyhvd/1sTWoGehd+iJ8iZB34vGGpXVeOOvFQPf5om
	3NvWOcx1hmbiHofW2R3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reDVs-0000000EuQW-1tpn;
	Sun, 25 Feb 2024 12:21:48 +0000
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reDVp-0000000EuPr-2b6m
	for linux-nvme@lists.infradead.org;
	Sun, 25 Feb 2024 12:21:47 +0000
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-59fc4d05861so1290054eaf.2
        for <linux-nvme@lists.infradead.org>; Sun, 25 Feb 2024 04:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708863703; x=1709468503; darn=lists.infradead.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1VsrEW364NLFbMOpVdWrVpVClR5o3UGDnlsGXHcP8Ms=;
        b=eoUSV5C29PVg0P/MP8NZZnDSijqQ2bbQJrjwshzeYPzq+/JWT5fab+f+PHirO5ddS2
         q8cDKVo6mQhv4mMKLAScUPj7oAeRPTvPPP66Ra+d3hI4DYonSxUYK0yzDQls9IVtIs9Q
         Uhe3gnOMcGf4gj7ggYaHoZfNR91qjfLSToTrpLCBvnYNBhMhUMm5+URgREUFhUboxMNU
         yZhAVg6NHkVa6+R7pHpl4QS/rAdNj14tFBpENNLDg0/vYrQMlYX0tAxl6TcNHosejfow
         YHXdMRbqh5nt0jTowUMMFc0UKPJG4tTPupdpVW75jeGrlLGBA11URnRROjmxUUp9oSZI
         eWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708863703; x=1709468503;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VsrEW364NLFbMOpVdWrVpVClR5o3UGDnlsGXHcP8Ms=;
        b=hyJK+jw14kSekK06oP7TuM118Q9ct1XwnMF7IT1oL94qcs/svU5UPotPfqBNVSXFVc
         KeLGyFiCjKh3ooQJ0qBZm7FHbytC+y7uofK9xjW/lCokh3uBu8mvwZOMx8FRCZ6V9TKU
         eoHD+k8MILFI3X5RHlWTbv0SDAWCqQocryW0LkqyYLOHDo0bod6JaewNV0QJOcBYr9Bq
         NT0lC1U36hWHWkvgMd2x7LwMSH+XQ77EDU/fHGzJTMX89KWqz+FO6XzREej/fg8Kczg2
         JDHbjrgt57XlXqmfhgcdEK/o5bIRSwaPY5e4oH13p115Ggm9RXMsbY/ZsraV3xdegPhP
         v2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXsV/5IkrNhpWrNd4RuuX0BSuvCIXWpzqyZK4U2NALQ3Vrj3ZFfpdAvnCl66wjm3pPMO0gUORH+TkJMmSZDWc/Zxrs81XFfxyRHSOPF3Kg=
X-Gm-Message-State: AOJu0YxrbbLMW+ZNgqTZTYnxYdP4WRrI4qeyd7j5HZAeQJ0Hqek9JwhM
	q+l7eF8K3WO8DCJfykRr/z/qIMRE6dR4AQCYfi5byiHu4hJ1d5GQ
X-Google-Smtp-Source: AGHT+IHCCjz5G11xwMXvR57ze0SaNofitVx3jUtjCSoTmI46aCxCdio39YUhl9mRABM4LyLCND/KWQ==
X-Received: by 2002:a05:6358:5413:b0:17b:79ee:f9dc with SMTP id u19-20020a056358541300b0017b79eef9dcmr6073415rwe.3.1708863703133;
        Sun, 25 Feb 2024 04:21:43 -0800 (PST)
Received: from dw-tp ([171.76.80.106])
        by smtp.gmail.com with ESMTPSA id t124-20020a628182000000b006e43b99a6c6sm2395792pfd.118.2024.02.25.04.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 04:21:42 -0800 (PST)
Date: Sun, 25 Feb 2024 17:51:34 +0530
Message-Id: <87il2c20q9.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org, linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, nilay@linux.ibm.com, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 05/11] block: Add core atomic write support
In-Reply-To: <87le7821ad.fsf@doe.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240225_042145_678683_74494BCD 
X-CRM114-Status: GOOD (  13.03  )
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

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> John Garry <john.g.garry@oracle.com> writes:
>
>> +
>> +	mask = boundary - 1;
>> +
>> +	/* start/end are boundary-aligned, so cannot be crossing */
>> +	if (!(start & mask) || !(end & mask))
>> +		return false;
>> +
>> +	imask = ~mask;
>> +
>> +	/* Top bits are different, so crossed a boundary */
>> +	if ((start & imask) != (end & imask))
>> +		return true;
>
> The last condition looks wrong. Shouldn't it be end - 1?
>
>> +
>> +	return false;
>> +}
>
> Can we do something like this?
>
> static bool rq_straddles_atomic_write_boundary(struct request *rq,
> 					       unsigned int start_adjust,
> 					       unsigned int end_adjust)
> {
> 	unsigned int boundary = queue_atomic_write_boundary_bytes(rq->q);
> 	unsigned long boundary_mask;
> 	unsigned long start_rq_pos, end_rq_pos;
>
> 	if (!boundary)
> 		return false;
>
> 	start_rq_pos = blk_rq_pos(rq) << SECTOR_SHIFT;
> 	end_rq_pos = start_rq_pos + blk_rq_bytes(rq);

my bad. I meant this...

   end_rq_pos = start_rq_pos + blk_rq_bytes(rq) - 1;
>
> 	start_rq_pos -= start_adjust;
> 	end_rq_pos += end_adjust;
>
> 	boundary_mask = boundary - 1;
>
> 	if ((start_rq_pos | boundary_mask) != (end_rq_pos | boundary_mask))
> 		return true;
>
> 	return false;
> }
>
> I was thinking this check should cover all cases? Thoughts?
>
>

-ritesh

