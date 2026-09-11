Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA6AC88E4D
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 21:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xJawB7JFgCcBwC+z0TwsYBCsCnjEqbnqt+DNYXOEKnA=; b=lzkNLinBFSl8pnbEWipwp3ZGgf
	UGfz3nyeQexjfxnu2Ft2qDo4EwzHtXa9VCo1UvJNvMLNI12bLaCsSToYfZ9iPnHUeglnUnzASRaMr
	c2zHWmXaEEsmhrj4yLe3E2I8eN5fpGcbPeg6EOLT99MRNEO8tG3bTczEdThICUgIecyvPy9d3TCXy
	3E3UP5PlAIN+qlrM9wfYhv+4Gntw8Tuf/murEyY/xhomUSVM8s0bWfHKvTkYwIp4Sv7VLyopecNvv
	P1jTkSdkOq7I3PLcXWE08ZCTloWvHtMJ3fRUw5mLIXoYg0l4nWlO8zV3pyGRdD9VynZ5xQ3VGdoUV
	qK4CWNGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x59AJ-00000000Czr-2aPV;
	Fri, 11 Sep 2026 21:52:11 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x59AH-00000000Cz2-06Cx
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 21:52:10 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso10579485e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 14:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789163527; x=1789768327;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xJawB7JFgCcBwC+z0TwsYBCsCnjEqbnqt+DNYXOEKnA=;
        b=DNChusLkIXRoXm5AqQ8/acsm1Kx6QI/CioQMa6n/fIYl/SSP3aMfQvEA0cpIGqVr2q
         YtdAGGpqTqQuqntGZO2bnluxbtiUBmbBXceOIWdBWp7d3pKxmLPa7zFC9/0jLmkKoKqx
         rTaacaITdg36xVUAXtYFAo1uyJ3O0FHx0ru2DV8115kDjFS8CbUhkYiniuRMEf/vI3Hl
         Ji08aZ7dvWJapyP3a5YNANH5aInnqnVkWDlaSlcBHoGBO0Lz17mV00KV1eeTUj50NEhE
         PRlbye7V5cpB/eVELK7U3vdHHiSEvAdXfwRLH1etSlnzdtw11ndWu2OLRlKkw7W+2klO
         cO7w==
X-Forwarded-Encrypted: i=1; AKwUvBxU9Csm4zI4Agia6jBZYZ9Ic/lSqkewuoKk6XbOtYrye9FoFWO5IiYLRQunDo8ppOIKsSAjHBiA3KV9@lists.infradead.org
X-Gm-Message-State: AFuF++nTCHoJ5IfWW6+GeYfjBdH0qSMDR9kh7ci4kerTrafNx2OYHxk8
	Feni+A2XnV6wrONgj+6aTmmrCiVrlkqeYo5PxILg/uZ0GgvNCly/qCg6
X-Gm-Gg: AYBFou3NYHRL/Tor10t5u15C+v6N2hjvVpcf1LuVqxnpA17mdY2lPOjaoVdbAdzhMq0
	ZQhnV2YHQiQ1gUX8YxG+l6nR0wx0+nsIi8I0iRI5EJJUNr6WpSgcgO1BrR5hraXl+zZeqca++6A
	qZCPfUoeK9bvmCq7CMpQHwQXAPIIgK6FGBoJwo7eKOMNqykGvd6R3bB2CgCHHSirzt8C8OGSabH
	vUk12OKnRdg61Ls+O5cq1iUxWKxFwYkEOWm2Bp5FpxBWIKYdHsUMsAuDWMkmph47wxW/TAwyEdf
	i8hvCcUIBwT3AawF35HfHV0m9SWEjL/FQB3SKIcjEHo+h0LTcNjJU7QRM/YamZeTehVaQmyq6rz
	fVnZaUFeqWZHw17WzawC28tHNE8AseI/K1U6a3gCUNEtTBbtQqjLDUFYgitT8y9lWmyYCimkYCu
	tbh+cN5WEQDvMQ2TdwpwN4zuLXjhEbcbTJTqvBSsF9XcImQH+EUsrunmyFYfQQ+FPtc1P+lcUTl
	dE675aNrgtwIq3AlHi+ERt/on8Sexfk
X-Received: by 2002:a7b:cd11:0:b0:49e:6052:4587 with SMTP id 5b1f17b1804b1-49e605245f6mr70643695e9.19.1789163526992;
        Fri, 11 Sep 2026 14:52:06 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb330bdcsm9020068f8f.13.2026.09.11.14.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 14:52:06 -0700 (PDT)
Message-ID: <3231383b-1383-4d24-bb04-6b348f8d04cd@grimberg.me>
Date: Sat, 12 Sep 2026 00:52:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] nvme-multipath: introduce latency I/O policy
To: Randy Jennings <randyj@purestorage.com>, Hannes Reinecke <hare@suse.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, dwagner@suse.de, kanie@linux.alibaba.com,
 jmeneghi@redhat.com, martin.petersen@oracle.com, john.g.garry@oracle.com,
 gjoyce@linux.ibm.com
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
 <f0215fbb-0e96-48de-8c6c-dd391fcf1d56@grimberg.me>
 <8ecbc5aa-0a5d-4780-9c34-bf433f5e6221@linux.ibm.com>
 <2a03f032-3fed-454c-a960-ac332b4c3fed@grimberg.me>
 <77d16701-c829-4fd7-bc4f-8fb51138d9d6@linux.ibm.com>
 <e6397f5d-b565-4219-95ed-4ace5f23c37d@suse.de>
 <CAPpK+O1QZKcab57unB2AsSMpPXHNVNHGarAXba4vvfYjm92=2g@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAPpK+O1QZKcab57unB2AsSMpPXHNVNHGarAXba4vvfYjm92=2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_145209_175540_9BD97D42 
X-CRM114-Status: GOOD (  16.61  )
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


> I think Nilay has done some great work with the latency scheduler, and
> we have it in our queue for evaluation.  But we have not done so yet,
> so I would appreciate if queue-depth would continue to be available
> until the latency scheduler has been more fully established as the
> prime choice.
>
> As to round-robin, I agree it would be great to see it disappear from
> all of our customers installations, but I have found it useful in
> evaluating multipath failover behavior because it is easier to reason
> about and construct the test cases.  So, I would appreciate if it
> would remain for debugging only.  I would certainly be open to a
> mechanism that made it a little bit hard to set round-robin as the
> queue policy, though.

Randy, would it be possible for you folks to evaluate it as well? I will ask
some folks on our side as well. I'm concerned that Nilay is the only one who
has evaluated it in his lab.

Overall, I am perfectly fine with the approach this path selector is 
taking, but I worry
that we are growing path-selectors that are slightly different in subtle 
ways...
TBH, I still don't understand what use-cases this path selector is more
appropriate than queue-depth, or vice-versa.

