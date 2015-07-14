From: keith.busch@intel.com (Keith Busch)
Date: Tue, 14 Jul 2015 20:14:26 +0000 (UTC)
Subject: Partitions and end-to-end protection
In-Reply-To: <yq1si8qqz91.fsf@sermon.lab.mkp.net>
References: <55A40881.5000108@ranbarg.com>
 <alpine.LNX.2.00.1507131909210.15930@localhost.lm.intel.com>
 <20150714180634.GB10203@infradead.org> <yq1a8uyshso.fsf@sermon.lab.mkp.net>
 <20150714184344.GA29437@infradead.org> <yq11tgash12.fsf@sermon.lab.mkp.net>
 <alpine.LNX.2.00.1507141916210.15930@localhost.lm.intel.com>
 <yq1wpy2r0lz.fsf@sermon.lab.mkp.net>
 <alpine.LNX.2.00.1507141941140.15930@localhost.lm.intel.com>
 <yq1si8qqz91.fsf@sermon.lab.mkp.net>
Message-ID: <alpine.LNX.2.00.1507142009010.15930@localhost.lm.intel.com>

On Tue, 14 Jul 2015, Martin K. Petersen wrote:
>>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:
> Keith> PRACT=1 strips/generates PI only for a subset of valid NVMe
> Keith> meta-data formats, so we need something for the others.
>
> *sigh* I hate that non-PI metadata stuff so much.

And it gets even worse! PI formatted drives with metadata size > 8 bytes
don't use PRACT either.
