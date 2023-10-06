Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7136CE92FDF
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Oct 2023 04:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ix+sRq4XQRGJaHRfH6WXpO9zrY7MmqagNFx/9Jnm3Cw=; b=2IwvxlFMoIE5Q6sVuhw6YpZg2S
	m4qnAgxCtSJs9CMJJZIJs/giuNXkzu/5WYU0rv8Nsac2cKTXepwYqhafUREP3Pv8drknYXxsAm/sk
	sv3CN5Z3AqxiN0hQCxzS613p4Nmbf6gC/k4jBV03BuMBQqUzfYx3rjFZUgXTY7lXgFG6Ui0YwU2F9
	YQhldlA7OMJ8d51PzEZ6jfP6B+R97LzdD8d/c5eS854jTxpMGOkI0/Vggix5HwglE+SC0xPivZ0z9
	7F/VwJ3DJtY2LQxO/9VL6Tu12bcKnpCg3zhqeXcLjU2yM+gU1MK/umhavyb9qZDPqqLNHGEpRcfL4
	GM0M/xTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qocUe-004vSl-1k;
	Fri, 06 Oct 2023 04:31:16 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qocUb-004vRf-2k
	for linux-nvme@lists.infradead.org;
	Fri, 06 Oct 2023 04:31:15 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so1450827b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 05 Oct 2023 21:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696566669; x=1697171469; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ix+sRq4XQRGJaHRfH6WXpO9zrY7MmqagNFx/9Jnm3Cw=;
        b=uWQLBQc6uKgq0tl/gDyYEpF5/VnO6FPEnf4NER2A13Tae20JBl33fIwVVvS5GCpke5
         W4pozKewFu/OkKZNsJ4T9GMIL8x4GpYFREEs9/fkir1LYIskRB65IWbwHv1TC0UqNAuV
         Et5JaDe6az/vfMkS9s1oiLeEFszm//H0hSLpCyvp1XwTv+mO8H6O2IZbhPPbFAdylHPr
         PufuMQcJHsE5Vgjb5KnYMEBdr7Il2TZbVvXOlMa2fEl5TIcpb5WLhJdK7ygWt9TlV08W
         PfE2Z5/QMY6V35oFIB/sMn7xwfKRPgbwnm2NjqZuaFSAGflvrXi8l/a2799E4M1gvXXt
         fGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696566669; x=1697171469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ix+sRq4XQRGJaHRfH6WXpO9zrY7MmqagNFx/9Jnm3Cw=;
        b=YqKWa4rFR7OJ2I16TG4iQoafMbl8/LH0z5Jpx7Z4V5JzZYUqbZOiiyMHWIDAmpBjBL
         45K1+jLycjfxKrznGm9N5P/ocwYNDlxAfAPqVYPrRnxpzkRrwNXBMwf/pY6Mk2QvdXO6
         9OaAt7LZva444SF2JhNxzzVLt2hpU7vbtYOqYeylwEBxsSYqLo7T9vV6NZEDhlSURT6W
         LwC7ODah8NqnB1ZaYZU1Or2PG2fdMME/DV/vMcgWjqr8S7BllKLb1ZIwn1fZkTls0Bds
         0/FC0FGAuSKxoJkbzlFVF2bsLVFxDmgb0yC1iKXyxE3Cnn6H0gW/idbdtcrAxEUCj0wO
         tO3g==
X-Gm-Message-State: AOJu0YysRHLJxTLNam1Ai4ZHCQyvHELBRo4Nj/F5Tar1lRnp1+pv0w0+
	2MrsM28BIEW+Fqi9jcHom/f7Lw==
X-Google-Smtp-Source: AGHT+IHgkUMxgn1iEBVFJVYZt/afT8PIq1pP/h8RwAD8SFXjlpezcSfR4j9zUmA+wytXxYHwxrQQQg==
X-Received: by 2002:a05:6a20:1447:b0:14e:3daf:fdb9 with SMTP id a7-20020a056a20144700b0014e3daffdb9mr8351717pzi.22.1696566668815;
        Thu, 05 Oct 2023 21:31:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id v9-20020a62a509000000b0069029a3196dsm427960pfm.184.2023.10.05.21.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 21:31:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qocUT-00A4Ul-1m;
	Fri, 06 Oct 2023 15:31:05 +1100
Date: Fri, 6 Oct 2023 15:31:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Message-ID: <ZR+NiYIuKzEilkW3@dread.disaster.area>
References: <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
 <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
 <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
 <34c08488-a288-45f9-a28f-a514a408541d@acm.org>
 <yq1ttr6qoqp.fsf@ca-mkp.ca.oracle.com>
 <a2077ddf-9a8f-4101-aeb9-605d6dee3c6e@acm.org>
 <ZR86Z1OcO52a4BtH@dread.disaster.area>
 <d976868a-d32c-43d1-b5da-ebbc4c8de468@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d976868a-d32c-43d1-b5da-ebbc4c8de468@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_213114_114364_225D2F9A 
X-CRM114-Status: GOOD (  20.20  )
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

On Thu, Oct 05, 2023 at 03:58:38PM -0700, Bart Van Assche wrote:
> On 10/5/23 15:36, Dave Chinner wrote:
> > $ lspci |grep -i nvme
> > 03:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> > 06:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> > $ cat /sys/block/nvme*n1/queue/write_cache
> > write back
> > write back
> > $
> > 
> > That they have volatile writeback caches....
> 
> It seems like what I wrote has been misunderstood completely. With
> "handling a power failure cleanly" I meant that power cycling a block device
> does not result in read errors nor in reading data that has never been written.

Then I don't see what your concern is. 

Single sector writes are guaranteed atomic and have been for as long
as I've worked in this game. OTOH, multi-sector writes are not
guaranteed to be atomic - they can get torn on sector boundaries,
but the individual sectors within that write are guaranteed to be
all-or-nothing. 

Any hardware device that does not guarantee single sector write
atomicity (i.e. tears in the middle of a sector) is, by definition,
broken. And we all know that broken hardware means nothing in the
storage stack works as it should, so I just don't see what point you
are trying to make...

> Although it is hard to find information about this topic, here is what I found
> online:
> * About certain SSDs with power loss protection:
>   https://us.transcend-info.com/embedded/technology/power-loss-protection-plp
> * About another class of SSDs with power loss protection:
>   https://www.kingston.com/en/blog/servers-and-data-centers/ssd-power-loss-protection
> * About yet another class of SSDs with power loss protection:
>   https://phisonblog.com/avoiding-ssd-data-loss-with-phisons-power-loss-protection-2/

Yup, devices that behave as if they have non-volatile write caches.
Such devices have been around for more than 30 years, they operate
the same as devices without caches at all.

> So far I haven't found any information about hard disks and power failure
> handling. What I found is that most current hard disks protect data with ECC.
> The ECC mechanism should provide good protection against reading data that
> has never been written.  If a power failure occurs while a hard disk is writing
> a physical block, can this result in a read error after power is restored? If
> so, is this behavior allowed by storage standards?

If a power fail results in read errors from the storage media being
reported to the OS instead of the data that was present in the
sector before the power failure, then the device is broken. If there
is no data in the region being read because it has never been
written, then it should return zeros (no data) rather than stale
data or a media read error.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

