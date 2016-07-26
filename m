From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 26 Jul 2016 15:42:39 -0600
Subject: Bandwidth issues and blktrace debug
In-Reply-To: <CAD+HZHUXtCU0pYJnhPfUsoG3Lx=yGCDmdV5+rxb+LDC4vqSRQQ@mail.gmail.com>
References: <CA+-kpaTvU+5vbqk536ajVSxwKSfa+c_4Ks5wv4iaee7UfcOnqA@mail.gmail.com>
 <CAD+HZHWTf-78rMR9bRZdF_36gMah-RD87NBT-01NqcFLHKNnWQ@mail.gmail.com>
 <CA+-kpaQ1L0H_dcvqkyrd8d-zOjExE5tXXf88mPA+WpeorsSrDg@mail.gmail.com>
 <CAD+HZHUXtCU0pYJnhPfUsoG3Lx=yGCDmdV5+rxb+LDC4vqSRQQ@mail.gmail.com>
Message-ID: <ba521194-84d4-89c7-b16f-25e783446ccf@kernel.dk>

>>>> 259,1    0    94210     1.353042800  1597  Q   R 410329344 + 1792 [fio]
>
> request from 410329344 got requeued.

No it didn't, that's a Queue event for a Read. It's not a requeue event.

-- 
Jens Axboe
