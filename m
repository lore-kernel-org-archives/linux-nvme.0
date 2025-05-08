Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4BDC3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPM2nuyUYlMB2FrqlYHGhR3ey1tqTnhLzD2lp+HJm2c=; b=r0C8G1EDKltTNC2l8FpTPTB+DJ
	0RA6qVAME+IocSaEvtDL7CthaiT3zFLlKtLaZLe/cNHY5q0lWvKmlnFd8Fh+nztDI+2YXsITAtgmG
	oA2sGC3Knki6SiyyhDmol9o1+98Bx3kk/Ur5hAp0CedUk981T9dX8PnVIHRHlIg/W9SF5eb3Sebk/
	ZhKRiOoBUiiYO6mAxHVRvT4hTcIpNhX4tpVI4ktiAiqZsuilbiTzjNDk0A8zQnpyJRb5qHUqb4rEN
	QA3pzqn2Y4hirWOIlzipxqLPc2EaDShPxR5V587umqRsbyHOt6k7194fBYJVUv0ZI2xbNQzWfX8Eg
	1mNac4lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD0NT-00000000c5z-3I9c;
	Thu, 08 May 2025 12:29:27 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD0Jp-00000000bJY-3gXW
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 12:25:43 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-47688ae873fso10086791cf.0
        for <linux-nvme@lists.infradead.org>; Thu, 08 May 2025 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746707140; x=1747311940; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPM2nuyUYlMB2FrqlYHGhR3ey1tqTnhLzD2lp+HJm2c=;
        b=ocv87rnQlzr6FUw5vZvjjXxYRuAPihDJtyAMrEj30hyKw2KX9MkQu6nOJKiX3+ULyX
         neOM34JRqTlDogF1PcbeOkMDea5nmv2JRYYRLM/cHWbZ2uAWbDhqJjgtJZUEU2lP8I+R
         OPzZzgoFKvtpkkAZV9WDGEGcq2xmBFSayk9FQTi+uz4eAmrQRsxfCC0R19Zu19krPq7B
         g9caY6m+IsD1xrui/WlT+uSWh+l20KL/R8wfHwok70K9/taJwPOfpgY3L3BDk0aQVEnu
         s4u5x/hyl8pyJNrIKbQ/xOyqS+zG3NwraKJxGDkrxwTob1srlqbgI89NKQPSgegEHq1x
         +Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746707140; x=1747311940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPM2nuyUYlMB2FrqlYHGhR3ey1tqTnhLzD2lp+HJm2c=;
        b=QAiaTfNqgZfawE7xVDkIKKK2FLXtGDWheJ6Fw6Y6TbUp4Y5uasxKiCVtdfz4MUxVGx
         fXLdhzj011+31uEEHDFQzS/2f/7bIWrcqttqNk9HpquTdlUQyyZtnl/Zi6BblxAK4aeH
         S7MNlwCFNP8H1ouRBVirzzj5p5ypcrzMPuC8H/FCVNOLPYOz9YrAZZqy/MH94ApT99c9
         mLuuxWc3sgDeHBHlOj83X1LinRCK0v1a1AOYFFpvTPbdRATRED6/4/DDY4ARpinwLH1A
         t+On0pXn6khCVlwR5Nm3AT3XsEf6eOADToePFj1iyu1ANvRs9axrVFp+XUKlijSurT3y
         7yEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQltjZOgI1edOv+neKDJBz+tl6jmtxL1UicGbZvvZNWznqpOuMpDK41dgzX/BrOHdVTXHAuQMVVONu@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0X+FnetSJRFsT7+U2aadUyoetjsYJ8B38TMUUpX5M/CMMTgBV
	f0kEXiP2JhLWKxckOkF8ZUAHhfCq2obow/CJIjnf8I61UhrbSfvruAdJSGxDqe0=
X-Gm-Gg: ASbGncu9KqB1M3DLJeqrtinge434CWyUcasLUnehl9JsTAD9umicnyvy8NFrtrL49cq
	zeYyy67S2HhEe0aNdQw4WYnartMVOjWgzQ7fi1QGdF5ZOfm/3xhmZSJwe/rdsT14WuWzGQP83k6
	HrAwajpz3DiOakvyWQtf8aN5sZvcs/T72GSOJXy+2zBW3mqy9C+AxBO4y8Gj6AT3etMYQS08v6U
	hkhlryKpwq3LyrzFbU55kDTmKl2InYElygTGFdiWrpbk7n2xhs/ZiCx2MgPKEhmyNfwSSFbKTR3
	8jEUlRSoaapG8++9Ubos4aifbZ4eyMpGwbqWbL+imvL67MX7DGZkjwdFcAw62ZLGEDbmjAaEY5w
	5IkDUCRI6HbQB4OTw
X-Google-Smtp-Source: AGHT+IGjPkkheV8apeeXL7LUq2iF5xAtFaXB1jDnzmyHtoO9fJMw0oyoMGJs/ppBBX9R4BQ+OduBOg==
X-Received: by 2002:ac8:5955:0:b0:48d:7cb6:4010 with SMTP id d75a77b69052e-492264f43d0mr96133521cf.23.1746707140464;
        Thu, 08 May 2025 05:25:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4922126b6a3sm34885331cf.21.2025.05.08.05.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 05:25:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uD0Jn-000000001gm-10DS;
	Thu, 08 May 2025 09:25:39 -0300
Date: Thu, 8 May 2025 09:25:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Bernard Metzler <BMT@zurich.ibm.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Message-ID: <20250508122539.GA6371@ziepe.ca>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
 <BN8PR15MB251354A3F4F39E0360B9B41399B22@BN8PR15MB2513.namprd15.prod.outlook.com>
 <lembalemdaoaqocvyd6n3rtdocv45734d22kmaleliwjoqpnpi@hrkfn3bl6hsv>
 <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_052542_013294_9AEB3098 
X-CRM114-Status: UNSURE (   8.52  )
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

On Thu, May 08, 2025 at 07:03:03AM +0000, Shinichiro Kawasaki wrote:
> One left question is why the failure was not observed with rxe driver, but with
> siw driver. My mere guess is that is because siw driver calls id->add_ref() and
> cm_id->rem_ref().

Only siw uses the code in iwcm.c, rxe does not.

Bernard? What do you think about this analysis? I've never really
looked inside iwcm.c..

Thanks,
Jason

