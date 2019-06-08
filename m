From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 9 Jun 2019 04:48:37 +0900
Subject: [PATCH V6 1/6] nvme: Do not return in the middle of the subcommand
In-Reply-To: <BYAPR04MB57493403FE6895517AC1B39D86110@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190604154034.23386-1-minwoo.im.dev@gmail.com>
 <20190604154034.23386-2-minwoo.im.dev@gmail.com>
 <BYAPR04MB57493403FE6895517AC1B39D86110@BYAPR04MB5749.namprd04.prod.outlook.com>
Message-ID: <20190608194837.GB28228@minwoo-900X5N>

On 19-06-08 19:16:08, Chaitanya Kulkarni wrote:
> Hi Minwoo,
> 
> Thanks for your patch-series. I'm not sure I understand the comment in 
> the cover-letter, please correct me if I'm wrong.

Please let me thank you to keep reviewing this :)

>  From cover-letter:-
> 
> "  - The first patch has been updated being without an whitespace in
>      front of new label("ret") in a function.  The other lables added
>      followed the existing style in where it belongs to.
>      The default style would be great to follow the kernel style which
>      is non-space label, as suggested by Chaitanya."
> 
> Which I think you want to keep the labels as default kernel style. 
> without any spaces ?
> >
> > + ret:
> 
> I found spaces like above everywhere in this patch, am I missing something ?

I'm sorry if It was unclear.  Simply I meant that the default kernel
style will be prepared once this series is done because now the labels
from this series are following their own functions existing style.

If It's now following their own functions,  It would be dirty at the
commit point of view.

For example, 

223  close_fd:                                      
224         close(fd);                              
225                                                 
226 ret:                                           
227         return nvme_status_to_errno(err, false);

It's not about the clean-up patches so that we just can follow the
existing rules of each functions, and once it gets done, I can prepare
the clean-up patches for this one.

I hope you can agree with this, but if not, pleasae feel free to let me
know :)

Thanks,
