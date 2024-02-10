Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21943C48260
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Feb 2024 12:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eTKKCRVzP1Y6N+8sXUxJFdEE3i1c7vbnIzYg3l82Xh0=; b=vJC6Da2Gwty+9K2u0BVGqKUhyC
	Tcl5kmlG32KlmdLLrcV/hBLJ34P/RN1AArrhBOylliFWOKmmSUZQ4yDTwgAvo/0lQMBqxPMY8jj2r
	w+bvcfj8jUp8LSw1vqJC4U9j1x5rOe0dmfdxC42dawW9iSspYlbcZbAE/oyGhRXmQ6Ergw5sDjj+8
	qYwcmfvMuUbBtoA5ykNFSxApMUA+DYyYWrp+9+gZ5fLlIDF87W6Op4SxV62j6Fp+fCkyOf4RZ25SX
	kiZmLGMZYVV63zVg1DBVOLXukTuIlruWtNThk1o6oobFQV8WB2sGaVaQF8Df1CYCBr1NrdZJcvetr
	Ca2ZO97w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYmEG-00000001bza-0Fl5;
	Sat, 10 Feb 2024 12:13:08 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYmE8-00000001bz5-2gXW
	for linux-nvme@lists.infradead.org;
	Sat, 10 Feb 2024 12:13:02 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-200-vIU3xCq1MRabbdi4Cu8-TQ-1; Sat, 10 Feb 2024 12:12:56 +0000
X-MC-Unique: vIU3xCq1MRabbdi4Cu8-TQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Feb
 2024 12:12:35 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Feb 2024 12:12:35 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'John Garry' <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "djwong@kernel.org" <djwong@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "dchinner@redhat.com" <dchinner@redhat.com>,
	"jack@suse.cz" <jack@suse.cz>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "tytso@mit.edu" <tytso@mit.edu>,
	"jbongio@google.com" <jbongio@google.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"ojaswin@linux.ibm.com" <ojaswin@linux.ibm.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>
Subject: RE: [PATCH v3 00/15] block atomic writes
Thread-Topic: [PATCH v3 00/15] block atomic writes
Thread-Index: AQHaWS09K2I7bFfzB0C0GPvnJtedS7EDgm/g
Date: Sat, 10 Feb 2024 12:12:35 +0000
Message-ID: <da8f0dc3475746da8f612de6f7c72ad6@AcuMS.aculab.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
 <20240129061839.GA19796@lst.de>
 <12718838-7038-4d47-9287-e699e8808143@oracle.com>
In-Reply-To: <12718838-7038-4d47-9287-e699e8808143@oracle.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240210_041300_966639_FB5DE53D 
X-CRM114-Status: UNSURE (   3.75  )
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

Q2FuIHNvbWVvbmUgYWRkIGEgOiBhZnRlciBibG9jaz8NCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


