From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Mon, 26 Sep 2016 15:26:37 -0700
Subject: [PATCH 0/9] Introduce blk_quiesce_queue() and blk_resume_queue()
In-Reply-To: <20160926183308.GA13309@redhat.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
 <20160926183308.GA13309@redhat.com>
Message-ID: <8c5fb60c-0bb5-e405-eaba-576b5f8bd244@sandisk.com>

On 09/26/2016 11:33 AM, Mike Snitzer wrote:
> How much testing has this series seen?  Did you run it against the
> mptest testsuite? https://github.com/snitm/mptest

Hello Mike,

The output of mptest with MULTIPATH_BACKEND_MODULE="scsidebug":
# ./runtest
[ ... ]
SUCCESS
** summary **
PASSED:  test_00_no_failure test_01_sdev_offline test_02_sdev_delete 
test_03_dm_failpath test_04_dm_switchpg
FAILED:

I think this is the output we were hoping to see :-)

Bart.
