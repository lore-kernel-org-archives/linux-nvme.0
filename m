From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 10 Oct 2018 09:35:10 -0700
Subject: [PATCH v2 2/2] nvmet-fcloop: Suppress a compiler warning
In-Reply-To: <73fab5b8-b612-a6cd-e6c3-d55ee66cf75a@broadcom.com>
References: <20181010150820.203745-1-bvanassche@acm.org>
 <20181010150820.203745-3-bvanassche@acm.org>
 <73fab5b8-b612-a6cd-e6c3-d55ee66cf75a@broadcom.com>
Message-ID: <1539189310.195557.1.camel@acm.org>

On Wed, 2018-10-10@08:57 -0700, James Smart wrote:
> On 10/10/2018 8:08 AM, Bart Van Assche wrote:
> > diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> > index 5251689a1d9a..291f4121f516 100644
> > --- a/drivers/nvme/target/fcloop.c
> > +++ b/drivers/nvme/target/fcloop.c
> > @@ -648,6 +648,7 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
> >   			break;
> >   
> >   		/* Fall-Thru to RSP handling */
> > +		/* FALLTHRU */
> >   
> >   	case NVMET_FCOP_RSP:
> >   		if (fcpreq) {
> 
> Reviewed-by: James Smart <james.smart at broadcom.com>
> 
> I had no idea there was a "standard" way to declare this.

Thanks James for the review. A detailed description of which comments are recognized by
gcc is available on https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#Warning-Options:

The option argument n specifies what kind of comments are accepted:

-Wimplicit-fallthrough=0 disables the warning altogether.
-Wimplicit-fallthrough=1 matches .* regular expression, any comment is used as fallthrough comment.
-Wimplicit-fallthrough=2 case insensitively matches .*falls?[ \t-]*thr(ough|u).* regular expression.
-Wimplicit-fallthrough=3 case sensitively matches one of the following regular expressions:
-fallthrough
@fallthrough@
lint -fallthrough[ \t]*
[ \t.!]*(ELSE,? |INTENTIONAL(LY)? )?
FALL(S | |-)?THR(OUGH|U)[ \t.!]*(-[^\n\r]*)?
[ \t.!]*(Else,? |Intentional(ly)? )?
Fall((s | |-)[Tt]|t)hr(ough|u)[ \t.!]*(-[^\n\r]*)?
[ \t.!]*([Ee]lse,? |[Ii]ntentional(ly)? )?
fall(s | |-)?thr(ough|u)[ \t.!]*(-[^\n\r]*)?
-Wimplicit-fallthrough=4 case sensitively matches one of the following regular expressions:
-fallthrough
@fallthrough@
lint -fallthrough[ \t]*
[ \t]*FALLTHR(OUGH|U)[ \t]*
-Wimplicit-fallthrough=5 doesn?t recognize any comments as fallthrough comments, only attributes disable the warning.

Bart.
