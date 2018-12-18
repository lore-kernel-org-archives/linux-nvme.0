From: hch@lst.de (Christoph Hellwig)
Date: Tue, 18 Dec 2018 18:03:13 +0100
Subject: [PATCH v4 2/2] trace nvme submit queue status
In-Reply-To: <CAG3TDc1Od_aAq7VC5y_cu0mms2muzWXrBv-fCsHQkXEdXsBmoQ@mail.gmail.com>
References: <20181218045138.4282-1-yupeng0921@gmail.com>
 <20181218045138.4282-2-yupeng0921@gmail.com>
 <24f78f57-9786-effd-6ffe-f9a556211898@grimberg.me>
 <CAG3TDc1Od_aAq7VC5y_cu0mms2muzWXrBv-fCsHQkXEdXsBmoQ@mail.gmail.com>
Message-ID: <20181218170313.GA13540@lst.de>

On Mon, Dec 17, 2018@11:44:51PM -0800, peng yu wrote:
> Sorry, I don't quite understand your meaning. Do you mean I'd better
> change this:
>         trace_nvme_sq(req->rq_disk,
>                 nvmeq->qid,
>                 le16_to_cpu(cqe->sq_head),
>                 nvmeq->sq_tail);
> to something like below:
>         trace_nvme_sq(req->rq_disk, nvmeq->qid, le16_to_cpu(cqe->sq_head),
>                 nvmeq->sq_tail);
> Please let me know whether my understanding is correct.

Yes.  Let me know if this version that I've applied is fine with you:

http://git.infradead.org/nvme.git/commitdiff/ed537628e59166a080d618825a7d175565a9cad4
