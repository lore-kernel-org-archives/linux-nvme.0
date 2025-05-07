Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBE6C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 22:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rh4j5BvAfXZF7bmpZu0jQ/ugGagunI5OepSAuxXPpsE=; b=c+fjDIyt6pXOC2Pee+LGQgQHXB
	rcFTqfJRcmNNhaU3f3y07evp032f52YheVXM1gc6u+g1zaotV0xEa/74ae1dxWszN8yK2UNy5dEnP
	XnVPup9ZJqvHQK7QUz3zrxric4GdtliwjGUJ7lWzqz6GvAVf/T4BxLfF5k5qapw/Xrd5K9A3YMmPl
	5y6iaiaBoC87kT1PaQ3cpYvCxsDkJjafDY4+nR0jW+2lJrRQOBHSB0ixb3Ja+3RjYBvJmYvxlyt3Q
	NqTEW8WNWncoh3eI5x+qBpg3zSBnL0AxSsc2xGiXPjK7AslH6Bt1qTZ4PGgOXjWp7b2RBry5d6uFZ
	KQcgqpVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCmpD-0000000GqJv-3oCo;
	Wed, 07 May 2025 22:01:11 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCmnd-0000000Gq5j-0S0a
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 21:59:34 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-22c33677183so3981975ad.2
        for <linux-nvme@lists.infradead.org>; Wed, 07 May 2025 14:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1746655172; x=1747259972; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rh4j5BvAfXZF7bmpZu0jQ/ugGagunI5OepSAuxXPpsE=;
        b=QoSAOEi2+MoWvdHbrEfzfh0ktWwwr5F5sbSfxcZxrYhK25Flg+Zgy9Vgl7EiPR+koQ
         pAeLaB5Q9s1Ypx3Tz/+1lwe9vl4vmKc9751HduK7hO2pqeACwd3MDzI3TKbf/Y0haehD
         7ahusCbtzG/d+i/Xi7FeySWWUVka9BkCGSIUkA5qw8/E/8QfrhsZNFEPciqYU+wgX1/H
         2lRf3Bay3bqS6tZs1sLX/OmuKi5HZLcsD/KYfWeOrmqa3yJeMVG4ekqLV++pL/ZcdHX8
         1dfxkrkiNn1LXbQqaD4McxuHDTuUCRGmhf5EXiY6cjWu+Mjc8e0sqTnCcf+SO7nYaW7C
         JC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746655172; x=1747259972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rh4j5BvAfXZF7bmpZu0jQ/ugGagunI5OepSAuxXPpsE=;
        b=eHpbwnqvVu47fZBu9wRcPROAGvP3DjfHAAi589S6+AKCy5ImiKiQr04xH55wjI+AA5
         ujLxs6u4QRGWNZ0eu5GvR7Sl0nkUGYmxH192IVdVJhaMnyI0/+WO4+8/BfK0C8thfkHz
         f4U4Uhi5thJpBf1c5osIMsknGZBl0tupFg9HO4XBXZtf0VxPhrTX/vOgddvNGIQj5ysk
         RSq5pHXjI2Zf9/cmYLMXLzTnI4PNfhBZ2eFOE2YhggmHZ6Tdf69uQgoIXN6Sbnbkd4Xj
         Db0mnPUYEmeMFxLiCQKZOBR7UceGKOqegPFuhzCCuo9+W620bJmUNRJtaAdbg3VwX5Dn
         jpDw==
X-Forwarded-Encrypted: i=1; AJvYcCVoaeCRhxD4uNeCkr43cgNAQjBEMY7djgRXlLPwD0M9+zodZLCij9hxSjS6kKPj94PIda4AIr8CT7Wg@lists.infradead.org
X-Gm-Message-State: AOJu0Yx6vr8QBogPsMRmKDdjXoJH87Nuw1H7ehbMoQydQsYpxUYxYUKD
	rBnylLU/Cgr8x4kjlyS8ro+rWZHJQRati9N8wvE/svw8bP223dFF69l1nBMTeZA=
X-Gm-Gg: ASbGncsvdaI4wXhU4cG1TXdVCkzvdKt8DiNJosp2Jalz9nRzZtcZ/a0WCaGI9MZ1qnS
	lpPdvg/Ua+u0UK8JlrH5wt9GGEWanjO5C4bqogi2ZaRjIxfBXkTG7PXiteBjN34WOfFj4T9Ty8n
	BDDWMdqkcsLM1qYVQuh6cZ3ZB8W+qvlaDRyXPzXnoTs0EVqWKFYd3UABfu9dpmTbRYk4pbukclr
	HOA0rg5F7uiUzKIPcgcJl3vZOH9p4F2+VoFKqyl+7l5qmH074KIH4PatkVFEVi2XX4bkuvyGuw9
	cNhooZ0iadtDQhIgM9l6VT1MHoHtYq6CId7+oqpZOuf8sHjyy4Dxp8MnfnT8YxajLYKv8+KQWht
	LhVQHPD2vz24XLL2qr3rNoXUA
X-Google-Smtp-Source: AGHT+IE1xxxerfJkV5Vbq7cdaXtmbfAA/IeC6rJzLbxihaJKNjABSSmh0OYDfzxkDN41CkecVlaUHQ==
X-Received: by 2002:a17:903:2286:b0:21f:988d:5756 with SMTP id d9443c01a7336-22e5ecdafcbmr68689475ad.42.1746655172014;
        Wed, 07 May 2025 14:59:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fd4fsm99541775ad.146.2025.05.07.14.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 14:59:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uCmnY-00000000gXW-3xM7;
	Thu, 08 May 2025 07:59:29 +1000
Date: Thu, 8 May 2025 07:59:28 +1000
From: Dave Chinner <david@fromorbit.com>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: Laurence Oberman <loberman@redhat.com>, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: Sequential read from NVMe/XFS twice slower on Fedora 42 than on
 Rocky 9.5
Message-ID: <aBvXwComvV-uAqmb@dread.disaster.area>
References: <CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
 <aBaVsli2AKbIa4We@dread.disaster.area>
 <CAAiJnjor+=Zn62n09f-aJw2amX2wxQOb-2TB3rea9wDCU7ONoA@mail.gmail.com>
 <aBfhDQ6lAPmn81j0@dread.disaster.area>
 <7c33f38a52ccff8b94f20c0714b60b61b061ad58.camel@redhat.com>
 <a1f322ab801e7f7037951578d289c5d18c6adc4d.camel@redhat.com>
 <aBlCDTm-grqM4WtY@dread.disaster.area>
 <CAAiJnjo87CEeFrkHbXtQM-=+K9M8uEpythLthWTwM_-i4HMA_Q@mail.gmail.com>
 <aBqDGY1i3RePyzaB@dread.disaster.area>
 <CAAiJnjp6WuVaxXbjndF8dB3fuWCuWz7Nqzpz0uEu2BOqyZUQHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAiJnjp6WuVaxXbjndF8dB3fuWCuWz7Nqzpz0uEu2BOqyZUQHg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_145933_338592_5899695D 
X-CRM114-Status: GOOD (  12.23  )
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

On Wed, May 07, 2025 at 03:26:08PM +0300, Anton Gavriliuk wrote:
> > `iostat -dxm 5` output during the fio run on both kernels will give us some indication of the differences in IO patterns, queue depths, etc.
> 
> iostat files attached.

Yeah, that definitely looks like MD is the bottleneck. In both
traces the NVMe drives are completing read IOs in about 110-120us.
In fedora 42, the nvme drives are not at 100% utilisation so the md
device is not feeding them fast enough.

That can also be seen in that the rocky 9.5 kernel with a nvme
device queue depth of about 4 IOs, whilst it is only 1.5 for the
fedora 42 kernel.

Given that nobody from the block/MD side of things has responded
with any ideas yet, you might just have to bisect it to find out
where things went wrong...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

