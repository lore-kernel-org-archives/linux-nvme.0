From: Darren.Trapp@cavium.com (Trapp, Darren)
Date: Thu, 19 Oct 2017 19:49:08 +0000
Subject: [PATCH v3 5/5] nvme_fc: add dev_loss_tmo timeout and remoteport
 resume support
In-Reply-To: <5c86018d-79f5-20d3-07d5-64bdd0344e34@gmail.com>
References: <20171017233248.6769-1-jsmart2021@gmail.com>
 <20171017233248.6769-6-jsmart2021@gmail.com>
 <32B40236-CB8E-461E-B765-AEF544AB981A@cavium.com>
 <5c86018d-79f5-20d3-07d5-64bdd0344e34@gmail.com>
Message-ID: <925E24E5-10DF-4E72-ADB7-F12A64E93655@cavium.com>

Thanks for the response. I think if it tears down the rport immediately and always calls back to the LLD it solves the problem.



On 10/19/17, 11:04 AM, "James Smart" <jsmart2021@gmail.com> wrote:


    Ahh. I understand. The wait_for_completions are in the lldd and I know 
    older code shows had the sequence you describe. True, if we reuse the 
    remoteport struct, as references never expired, the delete call would 
    have never occurred. So this is a bug with what's there.
    
    I think the cleanest fix is to have the delete callback occur as soon as 
    the delete_associations are done - as that will always occur and do so 
    rather quickly. If needed, if we find we are reusing a remoteport struct 
    and we hadn't called the delete, we call it prior to returning to the 
    second register remoteport call, which should work as well.
    
    note: as when we call remoteport_delete (ref cnt and free vs association 
    terminate) is independent from dev_loss_tmo, it shouldn't affect this 
    dev_loss patch set.
    
    -- james
    
