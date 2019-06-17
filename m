From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 17 Jun 2019 10:39:50 -0700
Subject: [PATCH V6 6/6] fabrics: Return errno mapped for fabrics error
 status
In-Reply-To: <20190612122646.GA32660@minwooim-desktop>
References: <7710edd4-5277-615c-426f-f9d48da8cb99@grimberg.me>
 <20190604154034.23386-1-minwoo.im.dev@gmail.com>
 <20190604154034.23386-7-minwoo.im.dev@gmail.com>
 <BYAPR04MB57497DFEEC77ED6D43998ED086110@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20190608200112.GC28228@minwoo-900X5N>
 <CGME20190611000218epcas3p3270ae3bfaa97cd686a7006810c453988@epcms2p1>
 <20190611051309epcms2p1e47e656deb584057d428eaec018a363e@epcms2p1>
 <667f4f9e-9356-44fb-d7fd-14d00b5393ea@grimberg.me>
 <20190612122646.GA32660@minwooim-desktop>
Message-ID: <4a7a6044-3de6-c099-bdbd-02065c9ef6cb@grimberg.me>


>> Question, this is a case where the numrec is different but the genctr is
>> the same? I think we need to fail if the genctr is the same, but we need
>> to start over if the genctr is different.
> 
> This is the case where you pointed it out.  But we don't know if
> genctr is different or not because we don't have any notifying code
> in nvmf_get_log_page_discovery().  Even genctr is different but the
> retries count is exhausted to max_retries, it does not notify this
> situation to the caller to retry it.
> 
> Would you mind if the following patch is added to this series?  If not, we
> need to change the design concept which tries to avoid infinite loop that
> had been introduced by Hannes's commit 3cbcd165b47.

Thats fine, also if the numrec is different then it should be an error
in this case I think.
