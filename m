Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40346CCA476
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Oct 2025 08:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YpZbJ1QMIGXsJO95EeDbekSvm5I9yv7BUeFhQgDIPcg=; b=rTajp0LGTfzS0ozSKPV2HGiEX3
	wkf0i9DEAiyqtPo2oPdfQIELO4teuo5InCXXGrPKwmy3JKJnxsQ496sTqK9nw5kt7yNSqcQisyQkJ
	Q4iuWsDF56vs3+OJ284SRL4VOAq+NbwjB3KAX8o2U9pI2+JKRgNn2KkIsPC/G7JXFmn12NdxJ8urP
	/cYMbZ0KIDWAH3zIw5DkaegbIfV+3kCe/FkBtGEjRuqrLl1VJ4F0ci3Si/xDEA3Y+Gm1wOAiPjgor
	XSBfWbzMHP3HL0HCH7PomgPPHa8VP072tfQiRv8d6XxEPC1kwrCdcbfCts46QAXEC7Dlq6/nNnu8M
	NWfbcNbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v633p-00000001Xqt-2Gjo;
	Tue, 07 Oct 2025 08:28:41 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v633m-00000001Xq5-2mAT
	for linux-nvme@lists.infradead.org;
	Tue, 07 Oct 2025 08:28:40 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so5005734b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 07 Oct 2025 01:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1759825717; x=1760430517; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YpZbJ1QMIGXsJO95EeDbekSvm5I9yv7BUeFhQgDIPcg=;
        b=EJUIAnfOwKLvT8iKYyfpmfgsLg4DUc1QH/Qzw6g1okHZOCNlHoGLjSVbfcPqXyiUlM
         FTP8G97f9LOyAysfi35dtDuXOB9Yb6md9BVNPcTi/5nXl+dRt+KHPwFzShK0eEMP+KAa
         9YKF/TrUEgx59R156FflxQx5/C4T6klBPCeyUV9a20sPI3D27PhY8EM52/fqlMmnW71f
         TXkdqO7N/7W5PLK5yP494SFpCXvPoWNrAlFLx+P22O+y/YHsPDLc4yTa7uXhq52uTBM0
         eDuCckIMx3QCsg1kWqYZ+kf/TaYcQZ3HQso8A7OIx5Bk9uwUpFOy5MhcgV9VOArU1V5W
         3xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759825717; x=1760430517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpZbJ1QMIGXsJO95EeDbekSvm5I9yv7BUeFhQgDIPcg=;
        b=nT7fuX8CbfvLInHTbYzXGrQ1X6F3ohTj4JOhJzL5n6qevhyzBFAI+TZtELqV3d2ZUc
         9CKfn9CJAFrHZ4aWOO+b3Nxn8HjmwcKna8uCdVa9B5R3h904pworX2AXYvVCLkSkGkQX
         5Od3JRWqiO9IHkCH75FqynOLSC0VUDh+IxYlh2HMS1DxTGDzyj80YkXBmq/K09g/mIPu
         zOISw2t3BR+QI+Y9AXaymF2ixeSXFId+kk5i8r/AmqAx5vKKR8246hBPZsGA6t6tN8h4
         DI0x+L+NpKNYUFdLo/1gpk6EDs622zHUvobVP4EFPoF87ni8G1tlzivjeWAsuDzyT0LM
         JStA==
X-Forwarded-Encrypted: i=1; AJvYcCXW2ZKjRxW7VevQnxXt6InGq6DT+djqUOdDOUyj17J4Pa5u9QDdJ6YNv8BZg4t//NxvsZfu7RIzqeRV@lists.infradead.org
X-Gm-Message-State: AOJu0Yzvlqsx1tUzmrdHsp8ZX/nO6vZDJuptB8clEdKyt7nftC74Fmqp
	0iWNCU83wlJrODS+wz3pdj3KFVQgTVe1DREQvvd7Xn9th5vlW5U06JTDi/cmSxCbwz0=
X-Gm-Gg: ASbGncvmqNqZDNjCWXcynuIDd7GcNi10+NKdFJiG/bGENuwLgIDzp3b7w8yTQcd1cfC
	y5b+XIh/yu3FB/TA+BA96RnBnZ5QrpCO8OM9C3rNJiG4eYJSfwFiDwId8E3bbHsOeOfhxlSG15h
	WPo3Ua99Xq84SewXbNpsZUwVgxQ4MnVSJnnCPkN0hDQpEhxkMW1lFXT5NIzfBw/JpLnP8ublvNr
	VicVigJH1DYkhgL1OL1ybelEJnHzkuQmGc8HsGwS4wCgei+hBgPjH9YcaBMsYErq3NnphUxsc1B
	Kyr1HdpiJTZIPXW95ZYKzbTVk/rdwMnehdi3FuRfyi0BrPtxv6r7BGSRstNkE5enBGrrHCNRqPW
	DYbAtjpLKbyQWgEfLxUp1ou1zE+y9q9LeiPZl24Sh8q2jINfV5kn4yQhdk710W9ZAp11Q
X-Google-Smtp-Source: AGHT+IEUcHDwSc5n5do+7fhgZx/8hDw0+PJKH3ejonSOLpIgKdjmmy9QWd5reRU+rDGGGOObBSG71w==
X-Received: by 2002:a17:902:e785:b0:24c:cc32:788b with SMTP id d9443c01a7336-28e9a5462aemr193596415ad.3.1759825717003;
        Tue, 07 Oct 2025 01:28:37 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:5196:9a8f:bb54:f0db])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b8796sm156615475ad.77.2025.10.07.01.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:28:36 -0700 (PDT)
Date: Tue, 7 Oct 2025 16:28:32 +0800
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: David Laight <david.laight.linux@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	akpm@linux-foundation.org, axboe@kernel.dk,
	ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
	home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
	kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com,
	xiubli@redhat.com
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with reverse
 lookup tables
Message-ID: <aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
 <20250926065556.14250-1-409411716@gms.tku.edu.tw>
 <CADUfDZruZWyrsjRCs_Y5gjsbfU7dz_ALGG61pQ8qCM7K2_DjmA@mail.gmail.com>
 <aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T>
 <CADUfDZq4c3dRgWpevv3+29frvd6L8G9RRdoVFpFnyRsF3Eve1Q@mail.gmail.com>
 <20251005181803.0ba6aee4@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251005181803.0ba6aee4@pumpkin>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251007_012838_944292_9BBA0D2B 
X-CRM114-Status: GOOD (  47.03  )
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

On Sun, Oct 05, 2025 at 06:18:03PM +0100, David Laight wrote:
> On Wed, 1 Oct 2025 09:20:27 -0700
> Caleb Sander Mateos <csander@purestorage.com> wrote:
> 
> > On Wed, Oct 1, 2025 at 3:18 AM Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> > >
> > > On Fri, Sep 26, 2025 at 04:33:12PM -0700, Caleb Sander Mateos wrote:  
> > > > On Thu, Sep 25, 2025 at 11:59 PM Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:  
> > > > >
> > > > > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > >
> > > > > Replace the use of strchr() in base64_decode() with precomputed reverse
> > > > > lookup tables for each variant. This avoids repeated string scans and
> > > > > improves performance. Use -1 in the tables to mark invalid characters.
> > > > >
> > > > > Decode:
> > > > >   64B   ~1530ns  ->  ~75ns    (~20.4x)
> > > > >   1KB  ~27726ns  -> ~1165ns   (~23.8x)
> > > > >
> > > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > > ---
> > > > >  lib/base64.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
> > > > >  1 file changed, 61 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/lib/base64.c b/lib/base64.c
> > > > > index 1af557785..b20fdf168 100644
> > > > > --- a/lib/base64.c
> > > > > +++ b/lib/base64.c
> > > > > @@ -21,6 +21,63 @@ static const char base64_tables[][65] = {
> > > > >         [BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
> > > > >  };
> > > > >
> > > > > +static const s8 base64_rev_tables[][256] = {
> > > > > +       [BASE64_STD] = {
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  -1,  -1,  -1,  63,
> > > > > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
> > > > > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
> > > > > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +       },
> > > > > +       [BASE64_URLSAFE] = {
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  -1,  -1,
> > > > > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
> > > > > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  63,
> > > > > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
> > > > > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +       },
> > > > > +       [BASE64_IMAP] = {
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  63,  -1,  -1,  -1,
> > > > > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
> > > > > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
> > > > > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > > > > +       },  
> > > >
> > > > Do we actually need 3 separate lookup tables? It looks like all 3
> > > > variants agree on the value of any characters they have in common. So
> > > > we could combine them into a single lookup table that would work for a
> > > > valid base64 string of any variant. The only downside I can see is
> > > > that base64 strings which are invalid in some variants might no longer
> > > > be rejected by base64_decode().
> > > >  
> > >
> > > In addition to the approach David mentioned, maybe we can use a common
> > > lookup table for A–Z, a–z, and 0–9, and then handle the variant-specific
> > > symbols with a switch.
> 
> It is certainly possible to generate the initialiser from a #define to
> avoid all the replicated source.
> 
> > >
> > > For example:
> > >
> > > static const s8 base64_rev_common[256] = {
> > >     [0 ... 255] = -1,
> > >     ['A'] = 0, ['B'] = 1, /* ... */, ['Z'] = 25,
> 
> If you assume ASCII (I doubt Linux runs on any EBCDIC systems) you
> can assume the characters are sequential and miss ['B'] = etc to
> reduce the the line lengths.
> (Even EBCDIC has A-I J-R S-Z and 0-9 as adjacent values)
> 
> > >     ['a'] = 26, /* ... */, ['z'] = 51,
> > >     ['0'] = 52, /* ... */, ['9'] = 61,
> > > };
> > >
> > > static inline int base64_rev_lookup(u8 c, enum base64_variant variant) {
> > >     s8 v = base64_rev_common[c];
> > >     if (v != -1)
> > >         return v;
> > >
> > >     switch (variant) {
> > >     case BASE64_STD:
> > >         if (c == '+') return 62;
> > >         if (c == '/') return 63;
> > >         break;
> > >     case BASE64_IMAP:
> > >         if (c == '+') return 62;
> > >         if (c == ',') return 63;
> > >         break;
> > >     case BASE64_URLSAFE:
> > >         if (c == '-') return 62;
> > >         if (c == '_') return 63;
> > >         break;
> > >     }
> > >     return -1;
> > > }
> > >
> > > What do you think?  
> > 
> > That adds several branches in the hot loop, at least 2 of which are
> > unpredictable for valid base64 input of a given variant (v != -1 as
> > well as the first c check in the applicable switch case).
> 
> I'd certainly pass in the character values for 62 and 63 so they are
> determined well outside the inner loop.
> Possibly even going as far as #define BASE64_STD ('+' << 8 | '/').
> 
> > That seems like it would hurt performance, no?
> > I think having 3 separate tables
> > would be preferable to making the hot loop more branchy.
> 
> Depends how common you think 62 and 63 are...
> I guess 63 comes from 0xff bytes - so might be quite common.
> 
> One thing I think you've missed is that the decode converts 4 characters
> into 24 bits - which then need carefully writing into the output buffer.
> There is no need to check whether each character is valid.
> After:
> 	val_24 = t[b[0]] | t[b[1]] << 6 | t[b[2]] << 12 | t[b[3]] << 18;
> val_24 will be negative iff one of b[0..3] is invalid.
> So you only need to check every 4 input characters, not for every one.
> That does require separate tables.
> (Or have a decoder that always maps "+-" to 62 and "/,_" to 63.)
> 
> 	David
>

Thanks for the feedback.
For the next revision, we’ll use a single lookup table that maps both +
and - to 62, and /, _, and , to 63.
Does this approach sound good to everyone?

Best regards,
Guan-Chun

> > 
> > Best,
> > Caleb
> > 
> 

